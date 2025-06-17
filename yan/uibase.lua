require "yan.datatypes.udim2"

--- The base of all interface elements.
---@class UIBase
---@field position UDim2
---@field size UDim2
---@field children table
---@field parent UIBase
local uibase = {}
uibase.__index = uibase

function uibase.new()
    local self = setmetatable({}, uibase)
    
    self.position = UDim2.new(0, 0, 0, 0)
    self.size = UDim2.new(0, 100, 0, 100)
    self.children = {}
    self.parent = nil
    
    return self
end

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