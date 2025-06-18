--- A 2 dimensional vector
---@class Vector2
---@field x number
---@field y number
Vector2 = {}
Vector2.__index = Vector2

--- Creates a new Vector2
---@param x number
---@param y number
---@return Vector2 vector
function Vector2.new(x, y)
    local self = setmetatable({
        x = x,
        y = y,
    }, Vector2)

    return self
end

return Vector2