local list = {}
local guibase = require("yan.instance.ui.guibase")
local utils = require("yan.utils")
list.__index = guibase

function list:New(o, screen, padding, align, scrollable)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "List"
    o.ListPadding = padding or 0
    o.Align = align or "left"
    o.Scrollable = scrollable
    o.CornerRoundness = 16

    o.ScrollOffset = 0
    o.ScrollSpeed = 20
    o.ScrollSize = {Size = 3, Offset = 25}

    o.ScrollbarVisible = true 
    o.ScrollbarColor = {R = 0, G = 0, B = 0, A = 0.5}
    o.ScrollbarWidth = 16

    function o:SetScrollbarColor(r, g, b, a)
        o.ScrollbarColor = {
            R = r, G = g, B = b, A = a
        }
    end
    
    function o:GetYOffsetForListItem(element)
        if #o.Children == 0 then return 0 end
        
        if element.LayoutOrder == 1 then return 0 + o.ScrollOffset end

        local totalOffset = 0
        
        for i = 1, element.LayoutOrder - 1 do
            local currentItem = o.Children[i]
            if currentItem ~= nil then
                local _, _, _, itemY = currentItem:GetDrawingCoordinates(true)

                totalOffset = totalOffset + itemY + o.ListPadding 
            end
            
        end

        return totalOffset + o.ScrollOffset
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
        
        if o.Scrollable == true and o.ScrollbarVisible == true then
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

return list