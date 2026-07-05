-- Custom blink.cmp source: completes environment variables after `$` or `env.`
local M = {}

function M.new(_opts)
    return setmetatable({}, { __index = M })
end

function M:get_trigger_characters()
    return { "$", "." }
end

local function make_items(label_prefix, start_col, end_col, cursor_row)
    local items = {}
    for name, value in pairs(vim.fn.environ()) do
        local detail = #value > 80 and (value:sub(1, 80) .. "...") or value
        table.insert(items, {
            label = label_prefix .. name,
            filterText = label_prefix .. name,
            kind = 6, -- Variable
            detail = detail,
            documentation = {
                kind = "markdown",
                value = string.format("**`%s`**\n\n```\n%s\n```", name, value),
            },
            textEdit = {
                newText = label_prefix .. name,
                range = {
                    start = { line = cursor_row, character = start_col },
                    ["end"] = { line = cursor_row, character = end_col },
                },
            },
        })
    end
    return items
end

function M:get_completions(ctx, callback)
    local before_cursor = ctx.line:sub(1, ctx.cursor[2])
    local cursor_row = ctx.cursor[1] - 1
    local cursor_col = ctx.cursor[2]

    -- $VARNAME pattern
    local dollar_suffix = before_cursor:match("%$([%w_]*)$")
    if dollar_suffix then
        local start_col = cursor_col - #dollar_suffix - 1
        callback({
            items = make_items("$", start_col, cursor_col, cursor_row),
            is_incomplete_forward = false,
            is_incomplete_backward = false,
        })
        return
    end

    -- env.VARNAME pattern (requires env to start at a word boundary)
    local env_suffix = before_cursor:match("^env%.([%w_]*)$")
        or before_cursor:match("[^%w_]env%.([%w_]*)$")
    if env_suffix then
        local start_col = cursor_col - #env_suffix - 4 -- 4 = #"env."
        callback({
            items = make_items("env.", start_col, cursor_col, cursor_row),
            is_incomplete_forward = false,
            is_incomplete_backward = false,
        })
        return
    end

    callback({ items = {}, is_incomplete_forward = false, is_incomplete_backward = false })
end

return M
