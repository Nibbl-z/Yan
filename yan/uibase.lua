require "yan.datatypes.udim2"
require "yan.datatypes.color"

--- The base of all interface elements that other elements inherit from
---@class UIBase
---@field position UDim2
---@field size UDim2
---@field backgroundcolor Color
---@field children table
---@field parent UIBase
uibase = {}
uibase.__index = uibase

--- Creates a new UIBase
function uibase:new()
    local object = {
        position = UDim2.new(0, 0, 0, 0),
        size = UDim2.new(0, 100, 0, 100),
        backgroundcolor = Color.new(1,1,1,1),
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
    
    local pxextra, pyextra = 0, 0
    
    if self.parent ~= nil then
        local parentpx, parentpy, parentsx, parentsy = self.parent:GetDrawingCoordinates()
        
        pxextra, pyextra = parentpx, parentpy
        width = parentsx
        height = parentsy
    end
    
    local pX = self.position.xscale * width + self.position.xoffset + pxextra
    local pY = self.position.yscale * height + self.position.yoffset + pyextra
    
    local sX = self.size.xscale * width + self.size.xoffset
    local sY = self.size.yscale * height + self.size.yoffset

    return pX, pY, sX, sY
end

--- Draws the UIBase to the screen
function uibase:draw()
    love.graphics.setColor(self.backgroundcolor:get())
    love.graphics.rectangle("fill", self:GetDrawingCoordinates())
    love.graphics.setColor(1,1,1,1)
end

--- Sets the element's parent to another element
---@param element UIBase
function uibase:setparent(element)
    table.insert(element.children, self)
    self.parent = element
end

return uibase