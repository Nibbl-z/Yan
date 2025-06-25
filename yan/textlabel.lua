require "yan.uibase"
require "yan.datatypes.color"

--- Displays text
---@class TextLabel : UIBase
---@field text string
---@field textsize number
---@field halign "left" | "center" | "right" | "justify"
---@field valign "top" | "center" | "bottom"
---@field textcolor Color
---@field _font love.Font
textlabel = uibase:new()
textlabel.__index = textlabel

--- Creates a new TextLabel
---@param text string
---@param textsize number
---@param halign "left" | "center" | "right" | "justify"
---@param valign "top" | "center" | "bottom"
function textlabel:new(text, textsize, halign, valign)
    local object = uibase:new()
    setmetatable(object, self)
    
    object.type = "TextLabel"

    object.text = text
    object.textsize = textsize
    object.halign = halign
    object.valign = valign
    object._font = love.graphics.newFont(object.textsize)
    
    object.textcolor = Color.new(0,0,0,1)
    
    return object
end

--- Draws the TextLabel to the screen
function textlabel:draw()
    uibase.draw(self)

    local pX, pY, sX, sY = self:getdrawingcoordinates()
    
    local yoffset = 0
        
    if self.valign == "center" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 0.5 - (self._font:getHeight() / 2) * #lines
    elseif self.valign == "bottom" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 1 - self._font:getHeight() * #lines
    end
    
    love.graphics.setColor(self.textcolor:get())
    love.graphics.setFont(self._font)
    love.graphics.printf(self.text, pX, pY + yoffset, sX, self.halign)
    love.graphics.setColor(1,1,1,1)
end

return textlabel