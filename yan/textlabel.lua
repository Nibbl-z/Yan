require "yan.uibase"
require "yan.datatypes.color"

--- Displays text
---@class TextLabel : UIBase
---@field text? string
---@field textsize? number
---@field halign? "left" | "center" | "right" | "justify"
---@field valign? "top" | "center" | "bottom"
---@field textcolor? Color
---@field textborder? Color
---@field _font? love.Font
---@field _shader? love.Shader
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
        textcolor = Color.new(0,0,0,1),
        textborder = Color.new(0,0,0,0)
    }, "TextLabel")
    
    setmetatable(object, self)

    object._font = love.graphics.newFont(object.textsize)

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