-- Treesitter incremental selection (VISION.md §4.5): <Enter> selects the
-- named node at cursor, <Enter> in visual expands to the nearest strictly
-- larger ancestor, <BS> shrinks back down the chain. Self-contained
-- replacement for the incremental_selection module dropped on treesitter's
-- `main` branch. Keymaps are buffer-local, attached only to parser buffers.

local M = {}

local stacks = {} -- bufnr -> stack of nodes; top of stack = current selection
local reselecting = false -- select_node() toggles visual mode internally

vim.api.nvim_create_autocmd("ModeChanged", {
    desc = "Clear incremental-selection stacks when leaving visual mode",
    group = vim.api.nvim_create_augroup("treeselect-clear", { clear = true }),
    pattern = "[vV\22]*:*",
    callback = function()
        if not reselecting and not vim.v.event.new_mode:find("^[vV\22]") then
            -- Visual mode is global (one selection at a time), so leaving it
            -- invalidates every stack; clearing them all also prevents stale
            -- nodes from surviving buffer wipes and bufnr reuse.
            stacks = {}
        end
    end,
})

local function range_eq(a, b)
    local a1, a2, a3, a4 = a:range()
    local b1, b2, b3, b4 = b:range()
    return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

--- Charwise-select the given node's range. Returns false for zero-width
--- nodes (nothing selectable, e.g. the root of an empty buffer).
local function select_node(node)
    local srow, scol, erow, ecol = node:range()
    if srow == erow and scol == ecol then
        return false
    end
    if ecol == 0 then -- exclusive end at col 0 -> selection ends on the previous line
        erow = erow - 1
        ecol = #(vim.api.nvim_buf_get_lines(0, erow, erow + 1, false)[1] or "")
    end
    if vim.api.nvim_get_mode().mode:find("^[vV\22]") then
        local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
        reselecting = true
        vim.api.nvim_feedkeys(esc, "nx", false)
        reselecting = false
    end
    vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
    return true
end

--- Normal-mode <Enter>: select the named node at the cursor.
function M.start()
    local buf = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, buf)
    if not ok or not parser then
        return
    end
    parser:parse() -- get_node() can return stale nodes on an unparsed tree
    local node = vim.treesitter.get_node()
    if not node then
        return
    end
    if select_node(node) then
        stacks[buf] = { node }
    end
end

--- Visual-mode <Enter>: expand to the nearest ancestor larger than the selection.
function M.expand()
    local stack = stacks[vim.api.nvim_get_current_buf()]
    if not stack or #stack == 0 then
        return M.start()
    end
    local node = stack[#stack]
    local parent = node:parent()
    while parent and range_eq(parent, node) do
        parent = parent:parent()
    end
    if not parent then
        return
    end
    stack[#stack + 1] = parent
    select_node(parent)
end

--- Visual-mode <BS>: shrink back to the previously selected node.
function M.shrink()
    local stack = stacks[vim.api.nvim_get_current_buf()]
    if not stack or #stack == 0 then
        return
    end
    if #stack > 1 then
        table.remove(stack)
    end
    select_node(stack[#stack])
end

--- Buffer-local keymaps; only called for buffers with a treesitter parser,
--- so the global quickfix <CR> behavior (autocmds.lua) is untouched.
function M.attach(buf)
    vim.keymap.set("n", "<Enter>", M.start, { buffer = buf, desc = "Treesitter: select node at cursor" })
    vim.keymap.set("x", "<Enter>", M.expand, { buffer = buf, desc = "Treesitter: expand selection" })
    vim.keymap.set("x", "<BS>", M.shrink, { buffer = buf, desc = "Treesitter: shrink selection" })
end

return M
