--- A 2 dimensional vector with scale and offset
---@class UDim2 
---@field xscale number
---@field xoffset number
---@field yscale number
---@field yoffset number
UDim2 = {}
UDim2.__index = UDim2

function UDim2.new(xScale, xOffset, yScale, yOffset)
    local self = setmetatable({
        xscale = xScale,
        xoffset = xOffset,
        yscale = yScale,
        yoffset = yOffset
    }, UDim2)

    return self
end

return UDim2