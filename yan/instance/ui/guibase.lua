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

    o.AnchorPoint = {X = 0, Y = 0}
    o.ZIndex = 1

    screen:AddElement(o)
    
    function o:GetDrawingCoordinates()
        local sX = o.Size.XScale * love.graphics.getWidth() + o.Size.XOffset
        local sY = o.Size.YScale * love.graphics.getHeight() + o.Size.YOffset
        
        local pX = (o.Position.XScale * love.graphics.getWidth() - sX * o.AnchorPoint.X) + o.Position.XOffset
        local pY = (o.Position.YScale * love.graphics.getHeight() + sY * o.AnchorPoint.Y) + o.Position.YOffset

        return pX, pY, sX, sY
    end

    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()

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

    function o:SetAnchorPoint(x, y)
       o.AnchorPoint = {
            X = x, Y = y
       } 
    end

    return o
end

return guiBase