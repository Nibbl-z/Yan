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
    
    o.ScrollOffset = 0
    o.ScrollSpeed = 20
    o.ScrollSize = {Size = 2, Offset = 0}
    
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
            o.ScrollOffset = utils:Clamp(o.ScrollOffset + y * o.ScrollSpeed, 0, -(sY * o.ScrollSize.Size) + sY + o.ScrollSize.Offset)
        end
    end
    
    return o
end

return list