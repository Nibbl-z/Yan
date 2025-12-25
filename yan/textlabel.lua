require "yan.uibase"
require "yan.datatypes.color"

--- Displays text
---@class TextLabel : UIBase
---@field text? string Text to display
---@field textsize? number Size of text
---@field halign? "left" | "center" | "right" Horizontal alignment of text
---@field valign? "top" | "center" | "bottom" Vertical alignment of text
---@field textcolor? Color Color of text
---@field textborder? Color Color of text border. Set the alpha component to 0 to disable the effect
---@field fontpath? string Path of custom font to use
---@field _font? love.Font
---@field _shader? love.Shader
---@field _lastFontpath? string
---@field _lastTextsize? number
textlabel = uibase:new({})
textlabel.__index = textlabel

--- Creates a new TextLabel
---@param props TextLabel
function textlabel:new(props)
    local object = uibase:_inherit(props, {
        text = "",
        textsize = 20,
        halign = "center",
        valign = "center",
        fontpath = nil,
        textcolor = Color.new(0,0,0,1),
        textborder = Color.new(0,0,0,0)
    }, "TextLabel")
    
    setmetatable(object, self)

    if object.fontpath == nil then
        object._font = love.graphics.newFont(object.textsize)
    else
        object._font = love.graphics.newFont(object.fontpath, object.textsize)
    end

    object._lastFontpath = object.fontpath
    object._lastTextsize = object.textsize

    object._shader = love.graphics.newShader("yan/shaders/textborder.glsl")
    object._shader:send("textcolor", {object.textcolor:get()})
    object._shader:send("bordercolor", {object.textborder:get()})
    return object
end

--- Draws the TextLabel to the screen
function textlabel:draw()
    uibase.draw(self)

    local pX, pY, sX, sY = self:getdrawingcoordinates()
    
    local yoffset = 0

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
        
    if self.valign == "center" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 0.5 - (self._font:getHeight() / 2) * #lines
    elseif self.valign == "bottom" then
        local _, lines = self._font:getWrap(self.text, sX)
        yoffset = sY * 1 - self._font:getHeight() * #lines
    end
    
    
    love.graphics.setFont(self._font)

    if self.textborder.a > 0 then
        self._shader:send("textcolor", {self.textcolor:get()})
        self._shader:send("bordercolor", {self.textborder:get()})
        love.graphics.setShader(self._shader)
    end
    love.graphics.setColor(self.textcolor:get())
    love.graphics.printf(self.text, pX, pY + yoffset, sX, self.halign)
    love.graphics.setShader()
    love.graphics.setColor(1,1,1,1)
end

return textlabel