--- A 2 dimensional vector with scale and offset
---@class UDim2 
---@field xscale number
---@field xoffset number
---@field yscale number
---@field yoffset number
UDim2 = {}
UDim2.__index = UDim2

--- Creates a new UDim2
---@param xscale number
---@param xoffset number
---@param yscale number
---@param yoffset number
---@return UDim2
function UDim2.new(xscale, xoffset, yscale, yoffset)
    local self = setmetatable({
        xscale = xscale,
        xoffset = xoffset,
        yscale = yscale,
        yoffset = yoffset
    }, UDim2)

    return self
end

function UDim2.__add(a, b)
    return UDim2.new(
        a.xscale + b.xscale,
        a.xoffset + b.xoffset,
        a.yscale + b.yscale,
        a.yoffset + b.yoffset
    )
end

function UDim2.__sub(a, b)
    return UDim2.new(
        a.xscale - b.xscale,
        a.xoffset - b.xoffset,
        a.yscale - b.yscale,
        a.yoffset - b.yoffset
    )
end

function UDim2.__mul(a, b)
    return UDim2.new(
        a.xscale * b,
        a.xoffset * b,
        a.yscale * b,
        a.yoffset * b
    )
end

return UDim2