local scrollable = {}
local guibase = require("yan.instance.ui.guibase")
local utils = require("yan.utils")
scrollable.__index = guibase

function scrollable:New(o, screen)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "Scrollable"
    o.CornerRoundness = 16
    
    o.ScrollOffset = 0
    o.ScrollSpeed = 20
    o.ScrollSize = {Size = 4, Offset = 20}
    
    o.ScrollbarVisible = true 
    o.ScrollbarColor = {R = 0, G = 0, B = 0, A = 0.5}
    o.ScrollbarWidth = 16

    o.MaskChildren = true

    function o:SetScrollbarColor(r, g, b, a)
        o.ScrollbarColor = {
            R = r, G = g, B = b, A = a
        }
    end

    function o:SetScrollSize(size, offset)
        o.ScrollSize = {Size = size, Offset = offset}
    end

    function o:WheelMoved(x, y)
        if o.Scrollable == false then return end
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        local mX, mY = love.mouse.getPosition()
        
        if utils:CheckCollision(mX, mY, 1, 1, pX, pY, sX, sY) then
            o.ScrollOffset = utils:Clamp(o.ScrollOffset + y * o.ScrollSpeed, 0, -((sY + o.ScrollSize.Offset) * o.ScrollSize.Size) + sY)
        end
    end

    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        if o.ScrollbarVisible == true then
            love.graphics.setColor(o.ScrollbarColor.R, o.ScrollbarColor.G, o.ScrollbarColor.B, o.ScrollbarColor.A)

            love.graphics.rectangle("fill", pX + sX - o.ScrollbarWidth, 
            pY - o.ScrollOffset / (o.ScrollSize.Size),
            o.ScrollbarWidth, 
            sY / (o.ScrollSize.Size) - (o.ScrollSize.Offset),
            8) 
        end
    end
    
    return o
end

return scrollable