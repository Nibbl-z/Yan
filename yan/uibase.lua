require "yan.datatypes.udim2"

--- The base of all interface elements that other elements inherit from. 
---@class UIBase
---@field position UDim2
---@field size UDim2
---@field children table
---@field parent UIBase
uibase = {}
uibase.__index = uibase

--- Creates a new UIBase
function uibase:new()
    local object = {
        position = UDim2.new(0, 0, 0, 0),
        size = UDim2.new(0, 100, 0, 100),
        children = {},
        parent = nil
    }
    
    setmetatable(object, self)
    
    return object
end

--- Gets the screenspace coordinates for position and size
function uibase:GetDrawingCoordinates()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    local pX = self.position.xscale * width + self.position.xoffset
    local pY = self.position.yscale * height + self.position.yoffset
    
    local sX = self.size.xscale * width + self.size.xoffset
    local sY = self.size.yscale * height + self.size.yoffset

    return pX, pY, sX, sY
end

function uibase:draw()
    love.graphics.rectangle("fill", self:GetDrawingCoordinates())
end

return uibase