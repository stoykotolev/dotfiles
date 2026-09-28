-- Colour math helpers. Pure functions, no vim API.
local M = {}

---@param hex string "#RRGGBB"
---@return integer r, integer g, integer b
function M.hex_to_rgb(hex)
    local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
    return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", r, g, b)
end

local function clamp(v)
    return math.min(255, math.max(0, math.floor(v + 0.5)))
end

---Linear interpolation of fg toward bg; alpha=1 keeps fg.
---@param fg string
---@param bg string
---@param alpha number 0..1
---@return string
function M.blend(fg, bg, alpha)
    local fr, fg_, fb = M.hex_to_rgb(fg)
    local br, bg_, bb = M.hex_to_rgb(bg)
    return rgb_to_hex(
        clamp(fr * alpha + br * (1 - alpha)),
        clamp(fg_ * alpha + bg_ * (1 - alpha)),
        clamp(fb * alpha + bb * (1 - alpha))
    )
end

---@param hex string
---@param amt number 0..1
---@return string
function M.darken(hex, amt)
    return M.blend(hex, "#000000", 1 - amt)
end

---@param hex string
---@param amt number 0..1
---@return string
function M.lighten(hex, amt)
    return M.blend(hex, "#FFFFFF", 1 - amt)
end

---WCAG relative luminance.
---@param hex string
---@return number 0..1
function M.luminance(hex)
    local r, g, b = M.hex_to_rgb(hex)
    local function chan(c)
        c = c / 255
        if c <= 0.03928 then
            return c / 12.92
        end
        return ((c + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * chan(r) + 0.7152 * chan(g) + 0.0722 * chan(b)
end

---WCAG contrast ratio between two colours (>= 1).
---@param a string
---@param b string
---@return number
function M.contrast(a, b)
    local la, lb = M.luminance(a), M.luminance(b)
    if la < lb then
        la, lb = lb, la
    end
    return (la + 0.05) / (lb + 0.05)
end

return M
