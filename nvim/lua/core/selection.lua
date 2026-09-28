-- Hand-rolled incremental selection on top of core vim.treesitter.
-- Replaces the incremental_selection module that the nvim-treesitter main
-- branch dropped. <CR> starts/grows a selection, <BS> shrinks it (keymaps
-- are buffer-local, set from plugins/treesitter.lua).

local M = {}

-- bufnr -> stack of nodes, innermost first
local stacks = {}

local function ranges_equal(a, b)
    local a1, a2, a3, a4 = a:range()
    local b1, b2, b3, b4 = b:range()
    return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

local function select_node(node)
    local srow, scol, erow, ecol = node:range()
    local end_row, end_col
    if ecol == 0 and erow > srow then
        -- Range ends at the very start of erow: last char is on the line above
        end_row = erow - 1
        end_col = math.max(vim.fn.col({ end_row + 1, "$" }) - 2, 0)
    else
        end_row = erow
        end_col = math.max(ecol - 1, 0)
    end
    -- Leave any active visual mode so `gv` picks up the new marks
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)
    vim.fn.setpos("'<", { 0, srow + 1, scol + 1, 0 })
    vim.fn.setpos("'>", { 0, end_row + 1, end_col + 1, 0 })
    vim.cmd("normal! gv")
end

function M.init()
    local node = vim.treesitter.get_node()
    if not node then
        return
    end
    stacks[vim.api.nvim_get_current_buf()] = { node }
    select_node(node)
end

function M.increment()
    local buf = vim.api.nvim_get_current_buf()
    local stack = stacks[buf]
    if not stack or #stack == 0 then
        return M.init()
    end
    local node = stack[#stack]
    -- Nodes go stale after buffer edits; fall back to a fresh selection
    local ok, parent = pcall(function()
        local p = node:parent()
        while p and ranges_equal(p, node) do
            p = p:parent()
        end
        return p
    end)
    if not ok then
        return M.init()
    end
    if parent then
        table.insert(stack, parent)
        node = parent
    end
    if not pcall(select_node, node) then
        return M.init()
    end
end

function M.decrement()
    local buf = vim.api.nvim_get_current_buf()
    local stack = stacks[buf]
    if not stack or #stack == 0 then
        return
    end
    if #stack > 1 then
        table.remove(stack)
    end
    if not pcall(select_node, stack[#stack]) then
        stacks[buf] = nil
    end
end

return M
