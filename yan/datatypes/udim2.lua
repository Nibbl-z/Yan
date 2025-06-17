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
function UDim2.new(xscale, xoffset, yscale, yoffset)
    local self = setmetatable({
        xscale = xscale,
        xoffset = xoffset,
        yscale = yscale,
        yoffset = yoffset
    }, UDim2)

    return self
end

return UDim2