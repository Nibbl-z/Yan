--- A 1 dimensional vector with scale and offset
---@class UDim 
---@field scale number
---@field offset number
UDim = {}
UDim.__index = UDim

--- Creates a new UDim
---@param scale number
---@param offset number
function UDim.new(scale, offset)
    local self = setmetatable({
        scale = scale,
        offset = offset
    }, UDim)

    return self
end

return UDim