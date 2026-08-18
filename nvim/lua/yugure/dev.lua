-- Live-reload plumbing while the scheme is being tuned.
local function reload()
    -- pcall so a syntax error mid-edit doesn't leave a cleared UI.
    local ok, err = pcall(vim.cmd.colorscheme, "yugure")
    if not ok then
        vim.notify("yugure reload failed: " .. err, vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("yugure-dev-reload", { clear = true }),
    -- `*` crosses path separators in autocmd patterns, so subdirs match too.
    pattern = {
        "*/lua/yugure/*.lua",
        "*/colors/yugure.lua",
    },
    callback = reload,
})

vim.api.nvim_create_user_command("YugureReload", reload, {
    desc = "Reload the yugure colorscheme",
})

-- A/B comparison against nordic.
local function ab_toggle()
    local target = vim.g.colors_name == "yugure" and "nordic" or "yugure"
    vim.cmd.colorscheme(target)
end

vim.api.nvim_create_user_command("YugureAB", ab_toggle, {
    desc = "Toggle between yugure and nordic",
})

vim.keymap.set("n", "<leader>uc", ab_toggle, {
    desc = "Toggle yugure/nordic colorscheme",
})

local ns = vim.api.nvim_create_namespace("yugure-dev")

local function open_scratch(lines)
    vim.cmd.new()
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    return buf
end

-- Contrast targets: accents and text/iron/subtle >= 4.5 vs base;
-- muted (comments) in the 3.2..4.6 band. Everything else is unflagged.
local accents = {
    rose = true,
    gold = true,
    foam = true,
    teal = true,
    iris = true,
    love = true,
}

local function flag_for(name, vs_base)
    if
        accents[name]
        or name == "text"
        or name == "iron"
        or name == "subtle"
    then
        return vs_base >= 4.5 and "OK" or "LOW"
    end
    if name == "muted" then
        if vs_base < 3.2 then
            return "LOW"
        elseif vs_base > 4.6 then
            return "HIGH"
        end
        return "OK"
    end
    return ""
end

local function contrast_report()
    local p = require("yugure.palette")
    local u = require("yugure.util")

    local sections = {
        { "bg layers", { "base", "low", "surface", "overlay", "med", "high" } },
        { "fg layers", { "text", "iron", "subtle", "muted", "faint" } },
        { "accents", { "rose", "gold", "foam", "teal", "iris", "love" } },
    }
    local listed = {}
    for _, sec in ipairs(sections) do
        for _, name in ipairs(sec[2]) do
            listed[name] = true
        end
    end
    local tints = {}
    for name in pairs(p) do
        if not listed[name] then
            table.insert(tints, name)
        end
    end
    table.sort(tints)
    table.insert(sections, { "derived tints", tints })

    local lines, marks = {}, {}
    for _, sec in ipairs(sections) do
        table.insert(lines, "== " .. sec[1] .. " ==")
        for _, name in ipairs(sec[2]) do
            local hex = p[name]
            local prefix = string.format("%-14s %-8s ", name, hex)
            local rest = string.format(
                "  base %5.2f  surf %5.2f  med %5.2f",
                u.contrast(hex, p.base),
                u.contrast(hex, p.surface),
                u.contrast(hex, p.med)
            )
            local fl = flag_for(name, u.contrast(hex, p.base))
            if fl ~= "" then
                rest = rest .. "  " .. fl
            end
            table.insert(lines, prefix .. "      " .. rest)
            local grp = "YugureSwatch" .. name
            vim.api.nvim_set_hl(0, grp, { bg = hex })
            table.insert(marks, {
                row = #lines - 1,
                col = #prefix,
                end_col = #prefix + 6,
                grp = grp,
            })
        end
        table.insert(lines, "")
    end

    local buf = open_scratch(lines)
    for _, m in ipairs(marks) do
        vim.api.nvim_buf_set_extmark(buf, ns, m.row, m.col, {
            end_col = m.end_col,
            hl_group = m.grp,
        })
    end
end

vim.api.nvim_create_user_command("YugureContrast", contrast_report, {
    desc = "Show palette WCAG contrast ratios",
})

-- Empty specs that are deliberate: the @lsp clear-list (incl. the
-- readonly clears) plus the no-op captures.
local function intentional_empty(name)
    return name:find("^@lsp") ~= nil
        or name == "@none"
        or name == "@spell"
        or name == "@nospell"
end

local function audit_report()
    if vim.g.colors_name ~= "yugure" then
        vim.cmd.colorscheme("yugure")
    end
    local groups = require("yugure").groups
    local active = vim.api.nvim_get_hl(0, {})

    -- (a) active groups neither defined by us nor linking into one of
    -- ours — candidates for ugly default fallbacks.
    local undefined = {}
    for name in pairs(active) do
        if
            not groups[name]
            and not name:find("^DevIcon")
            and not name:find("^YugureSwatch")
        then
            local seen, cur, resolves = {}, name, false
            while true do
                local nxt = active[cur] and active[cur].link
                if not nxt or seen[nxt] then
                    break
                end
                if groups[nxt] then
                    resolves = true
                    break
                end
                seen[nxt] = true
                cur = nxt
            end
            if not resolves then
                table.insert(undefined, name)
            end
        end
    end
    table.sort(undefined)

    -- (b) our groups whose spec is empty without being on the clear-list.
    local empties = {}
    for name, spec in pairs(groups) do
        if vim.tbl_isempty(spec) and not intentional_empty(name) then
            table.insert(empties, name)
        end
    end
    table.sort(empties)

    local lines = {
        string.format(
            "active but not yugure-defined (nor linked into it): %d",
            #undefined
        ),
    }
    for _, name in ipairs(undefined) do
        table.insert(lines, "  " .. name)
    end
    table.insert(lines, "")
    table.insert(
        lines,
        string.format("unexpectedly empty yugure specs: %d", #empties)
    )
    for _, name in ipairs(empties) do
        table.insert(lines, "  " .. name)
    end
    open_scratch(lines)
end

vim.api.nvim_create_user_command("YugureAudit", audit_report, {
    desc = "Audit yugure group coverage against active highlights",
})
