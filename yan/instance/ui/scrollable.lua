local scrollable = {}
local guibase = require("yan.instance.ui.guibase")
local utils = require("yan.utils")
scrollable.__index = guibase

function scrollable:New(o, screen, direction)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "Scrollable"
    o.CornerRoundness = 16
    
    o.ScrollOffset = 0
    o.ScrollSpeed = 20
    o.ScrollSize = {Size = 2, Offset = 0}
    
    o.ScrollbarVisible = true 
    o.ScrollbarColor = {R = 0, G = 0, B = 0, A = 0.5}
    o.ScrollbarWidth = 16
    o.ScrollbarSize = {Size = 0.3, Offset = 0}
    o.ScrollDirection = direction

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
            if o.ScrollDirection == "vertical" then
                o.ScrollOffset = utils:Clamp(o.ScrollOffset + y * o.ScrollSpeed, 0, -((sY * o.ScrollSize.Size + o.ScrollSize.Offset)) + sY)
            else
                o.ScrollOffset = utils:Clamp(o.ScrollOffset + y * o.ScrollSpeed, 0, -((sX * o.ScrollSize.Size + o.ScrollSize.Offset)) + sX)
            end   
        end
    end

    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        if o.ScrollbarVisible == true then
            love.graphics.setColor(o.ScrollbarColor.R, o.ScrollbarColor.G, o.ScrollbarColor.B, o.ScrollbarColor.A)

            if o.ScrollDirection == "vertical" then
                local scrollbarSize = (sY * o.ScrollbarSize.Size) + o.ScrollbarSize.Offset
                local maxY = sY
                
                print("THIS IS", math.abs(o.ScrollOffset) / ((o.ScrollSize.Size * sY) + o.ScrollSize.Offset))

                love.graphics.rectangle(
                    "fill", 
                    pX + sX - o.ScrollbarWidth, 
                    pY + maxY * (math.abs(o.ScrollOffset) / ((o.ScrollSize.Size * sY) + o.ScrollSize.Offset)),
                    o.ScrollbarWidth, 
                    scrollbarSize,
                    8
                ) 
            else
                local scrollbarSize = (sX * o.ScrollbarSize.Size) + o.ScrollbarSize.Offset
                local maxX = sX + scrollbarSize

                love.graphics.rectangle("fill", 
                pX - o.ScrollOffset / (o.ScrollSize.Size), 
                pY + sY - o.ScrollbarWidth,
                sX / (o.ScrollSize.Size) + (o.ScrollSize.Offset),
                o.ScrollbarWidth, 
                8)
                
                love.graphics.rectangle(
                    "fill", 
                    pX + maxX * (math.abs(o.ScrollOffset) / ((o.ScrollSize.Size * sX) + o.ScrollSize.Offset)),
                    pY + sY - o.ScrollbarWidth,
                    scrollbarSize,
                    o.ScrollbarWidth,
                    8
                ) 
            end
            
        end
    end
    
    return o
end

return scrollable