--- A RGBA color value
---@class Color
---@field r number
---@field g number
---@field b number
---@field a number
Color = {}
Color.__index = Color

--- Creates a new Color
---@param r number
---@param g number
---@param b number
---@param a number
function Color.new(r, g, b, a)
    local self = setmetatable({
        r = r,
        g = g,
        b = b,
        a = a
    }, Color)
    
    return self
end

--- Returns the RGBA values of the color, eg. to be used in `love.graphics.setColor`
---@return number, number, number, number
function Color:get()
    return self.r, self.g, self.b, self.a
end

return Color