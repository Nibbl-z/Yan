local guiBase = {}
local instance = require("yan.instance.instance")
guiBase.__index = instance

function guiBase:New(o, screen)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Position = {
        XOffset = o.Position.X,
        XScale = 0,
        YOffset = o.Position.Y,
        YScale = 0
    }
    
    o.Size = {
        XOffset = o.Size.X,
        XScale = 0,
        YOffset = o.Size.Y,
        YScale = 0
    }

    screen:AddElement(o)

    function o:Draw()
        local pX = o.Position.XScale * love.graphics.getWidth() + o.Position.XOffset
        local pY = o.Position.YScale * love.graphics.getHeight() + o.Position.YOffset

        local sX = o.Size.XScale * love.graphics.getWidth() + o.Size.XOffset
        local sY = o.Size.YScale * love.graphics.getHeight() + o.Size.YOffset

        love.graphics.rectangle("line", pX, pY, sX, sY)
    end

    function o:SetPosition(xS, xO, yS, yO)
        o.Position = {
            XOffset = xO,
            XScale = xS,
            YOffset = yO,
            YScale = yS
        }
    end
    
    function o:SetSize(xS, xO, yS, yO)
        o.Size = {
            XOffset = xO,
            XScale = xS,
            YOffset = yO,
            YScale = yS
        }
    end

    return o
end

return guiBase