require "yan.uibase"

--- Displays text.
---@class TextLabel : UIBase
---@field text string
---@field textsize number
---@field halign "left" | "center" | "right" | "justify"
---@field valign "top" | "center" | "bottom"
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
    
    self.text = text
    self.textsize = textsize
    self.halign = halign
    self.valign = valign
    self._font = love.graphics.newFont(self.textsize)
    
    return self
end

--- Draws the TextLabel
function textlabel:draw()
    local pX, pY, sX, sY = self:GetDrawingCoordinates()

    local yoffset = 0
        
    if self.valign == "center" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 0.5 - (self._font:getHeight() / 2) * #lines
    elseif self.valign == "bottom" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 1 - self._font:getHeight() * #lines
    end
    
    love.graphics.setFont(self._font)
    love.graphics.printf(self.text, pX, pY + yoffset, sX, self.halign)
end

return textlabel