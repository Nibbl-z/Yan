require "yan.uibase"
local utf8 = require("utf8")

--- A field for users to input text
---@class TextInput : UIBase
---@field text string
---@field placeholdertext string
---@field textsize number
---@field halign "left" | "center" | "right" | "justify"
---@field valign "top" | "center" | "bottom"
---@field textcolor Color
---@field placeholdertextcolor Color
---@field typingindicatorenabled boolean
---@field _font love.Font
---@field _typing boolean
textinput = uibase:new()
textinput.__index = textinput

--- Creates a new TextInput
---@param placeholdertext string
---@param textsize number
---@param halign "left" | "center" | "right" | "justify"
---@param valign "top" | "center" | "bottom"
function textinput:new(placeholdertext, textsize, halign, valign)
    local object = uibase:new()
    setmetatable(object, self)
    
    object.type = "TextInput"

    object.text = ""
    object.placeholdertext = placeholdertext
    object.textsize = textsize
    object.halign = halign
    object.valign = valign
    object.textcolor = Color.new(0,0,0,1)
    object.placeholdertextcolor = Color.new(0.5, 0.5, 0.5, 1)
    object.typingindicatorenabled = true
    
    object._font = love.graphics.newFont(object.textsize)
    object._typing = false

    return object
end

function textinput:update()
    uibase.update(self)

    if self._clicked then
        self._typing = true
        print("clicked")
    end

    if not self._hovered and love.mouse.isDown(1) then
        self._typing = false
        print("no more typing")
    end
end

--- Draws the TextInput to the screen
function textinput:draw()
    uibase.draw(self)

    local pX, pY, sX, sY = self:getdrawingcoordinates()
    
    local yoffset = 0
    
    local text = self.text .. (self._typing and "|" or "")

    if self.valign == "center" then
        local _, lines = self._font:getWrap(text, sX)
        yoffset = sY * 0.5 - (self._font:getHeight() / 2) * #lines
    elseif self.valign == "bottom" then
        local _, lines = self._font:getWrap(text, sX)
        yoffset = sY * 1 - self._font:getHeight() * #lines
    end
    
    love.graphics.setFont(self._font)
    
    if text == "" then
        love.graphics.setColor(self.placeholdertextcolor:get())
        love.graphics.printf(self.placeholdertext, pX, pY + yoffset, sX, self.halign)
    else
        love.graphics.setColor(self.textcolor:get())
        love.graphics.printf(text, pX, pY + yoffset, sX, self.halign)
    end
    
    love.graphics.setColor(1,1,1,1)
end

--- TextInput's hook into `love.textinput`
---@param text string
function textinput:textinput(text)
    if not self._typing then return end
    
    self.text = self.text..text
end

--- TextInput's hook into `love.keypressed`
---@param key love.KeyConstant
function textinput:keypressed(key)
    if not self._typing then return end

    if key == "backspace" then
        local byteoffset = utf8.offset(self.text, -1)
        
        if byteoffset then
            self.text = string.sub(self.text, 1, byteoffset - 1)
        end
    elseif key == "return" then
        self._typing = false
    end
end

return textinput