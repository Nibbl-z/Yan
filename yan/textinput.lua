require "yan.uibase"
local utf8 = require("utf8")

--- A field for users to input text
---@class TextInput : UIBase
---@field text? string The text that is typed in
---@field placeholdertext? string Text that shows when there is no text in the TextInput
---@field textsize? number Size of text
---@field halign? "left" | "center" | "right" Horizontal alignment of text
---@field valign? "top" | "center" | "bottom" Vertical alignment of text
---@field textcolor? Color Color of text
---@field textborder? Color Color of text border. Set the alpha component to 0 to disable the effect
---@field fontpath? string Path of custom font to use
---@field placeholdertextcolor? Color Color of placeholder text
---@field typingindicatorenabled? boolean If enabled, a line will show where the user is typing
---@field _font? love.Font
---@field _typing? boolean
---@field _shader? love.Shader
---@field _lastFontpath? string
---@field _lastTextsize? number
textinput = uibase:new({})
textinput.__index = textinput

--- Creates a new TextInput
---@param props TextInput
function textinput:new(props)
    local object = uibase:_inherit(props, {
        placeholdertext = "",
        text = "",
        textsize = 20,
        halign = "center",
        valign = "center",
        textcolor = Color.new(0,0,0,1),
        textborder = Color.new(0,0,0,0),
        placeholdertextcolor = Color.new(0.5, 0.5, 0.5, 1),
        typingindicatorenabled = true
    }, "TextInput")
    setmetatable(object, self)
    
    if object.fontpath == nil then
        object._font = love.graphics.newFont(object.textsize)
    else
        object._font = love.graphics.newFont(object.fontpath, object.textsize)
    end

    object._lastFontpath = object.fontpath
    object._lastTextsize = object.textsize

    object._typing = false

    object._shader = love.graphics.newShader("yan/shaders/textborder.glsl")
    object._shader:send("textcolor", {object.textcolor:get()})
    object._shader:send("bordercolor", {object.textborder:get()})

    return object
end

--- Updates the TextInput
function textinput:update()
    uibase.update(self)

    if self._button1clicked then
        self._typing = true
    end

    if self._typing then
        love.keyboard.setKeyRepeat(true)
    else
        love.keyboard.setKeyRepeat(false)
    end

    if not self._hovered and love.mouse.isDown(1) then
        self._typing = false
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
    
    if self.fontpath ~= nil then
        if self._lastFontpath ~= self.fontpath then
            if self._font ~= nil then
                self._font:release()
            end
            self._font = love.graphics.newFont(self.fontpath, self.textsize)
        end
    end

    if self._lastTextsize ~= self.textsize then
        if self._font ~= nil then
            self._font:release()
        end

        if self.fontpath ~= nil then
            self._font = love.graphics.newFont(self.fontpath, self.textsize)
        else
            self._font = love.graphics.newFont(self.textsize)
        end
    end

    love.graphics.setFont(self._font)
    
    if text == "" then
        if self.textborder.a > 0 then
            self._shader:send("textcolor", {self.placeholdertextcolor:get()})
            self._shader:send("bordercolor", {self.textborder:get()})
            love.graphics.setShader(self._shader)
        end

        love.graphics.setColor(self.placeholdertextcolor:get())
        love.graphics.printf(self.placeholdertext, pX, pY + yoffset, sX, self.halign)
    else
        if self.textborder.a > 0 then
            self._shader:send("textcolor", {self.textcolor:get()})
            self._shader:send("bordercolor", {self.textborder:get()})
            love.graphics.setShader(self._shader)
        end

        love.graphics.setColor(self.textcolor:get())
        love.graphics.printf(text, pX, pY + yoffset, sX, self.halign)
    end

    love.graphics.setShader()
    
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