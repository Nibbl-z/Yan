local label = {}
local instance = require("yan.instance.instance")
label.__index = instance

function label:New(o, screen, text, textSize, align)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Text = text
    o.TextSize = textSize
    o.Align = align

    o.Font = love.graphics.newFont(o.TextSize)
    
    screen:AddElement(o)

    function o:Draw()
        love.graphics.setFont(o.Font)
        love.graphics.printf(o.Text, o.Position.X, o.Position.Y, o.Size.X, o.Align)
    end
    
    return o
end

return label