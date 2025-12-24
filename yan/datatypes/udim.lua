--- A 1 dimensional vector with scale and offset
---@class UDim 
---@field scale number
---@field offset number
UDim = {}
UDim.__index = UDim

--- Creates a new UDim
---@param scale number
---@param offset number
---@return UDim
function UDim.new(scale, offset)
    local self = setmetatable({
        scale = scale,
        offset = offset
    }, UDim)

    return self
end

function UDim.__add(a, b)
    return UDim.new(
        a.scale + b.scale,
        a.offset + b.offset
    )
end

function UDim.__sub(a, b)
    return UDim.new(
        a.scale - b.scale,
        a.offset - b.offset
    )
end

function UDim.__mul(a, b)
    return UDim.new(
        a.scale * b.scale,
        a.offset * b.offset
    )
end

return UDim