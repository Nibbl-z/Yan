local label = {}
local instance = require("yan.instance.instance")
label.__index = instance

function label:New(o, screen, text, textSize, align)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Text = text
    o.TextSize = textSize
    o.Align = align
    o.Position = {
        XOffset = o.Position.X,
        XScale = 0,
        YOffset = o.Position.Y,
        YScale = 0
    }

    o.Font = love.graphics.newFont(o.TextSize)
    
    screen:AddElement(o)

    function o:Draw()
        love.graphics.setFont(o.Font)
        love.graphics.printf(
            o.Text, 
            o.Position.XScale * love.graphics.getWidth() + o.Position.XOffset,
            o.Position.YScale * love.graphics.getHeight() + o.Position.YOffset,
            o.Size.X, 
            o.Align
        )
    end

    function o:SetPosition(xS, xO, yS, yO)
        o.Position = {
            XOffset = xO,
            XScale = xS,
            YOffset = yO,
            YScale = yS
        }
    end
    
    return o
end

return label