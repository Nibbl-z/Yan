--- A 2 dimensional vector
---@class Vector2
---@field x number
---@field y number
Vector2 = {}
Vector2.__index = Vector2

--- Creates a new Vector2
---@param x number
---@param y number
---@return Vector2
function Vector2.new(x, y)
    local self = setmetatable({
        x = x,
        y = y,
    }, Vector2)

    return self
end

function Vector2.__add(a, b)
    return Vector2.new(
        a.x + b.x,
        a.y + b.y
    )
end

function Vector2.__sub(a, b)
    return Vector2.new(
        a.x - b.x,
        a.y - b.y
    )
end

function Vector2.__mul(a, b)
    return Vector2.new(
        a.x * b,
        a.y * b
    )
end

return Vector2