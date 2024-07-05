local list = {}
local guibase = require("yan.instance.ui.guibase")
list.__index = guibase

function list:New(o, screen, padding, align)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "List"
    o.ListPadding = padding or 0
    o.Align = align or "left"
    
    function o:GetYOffsetForListItem(element)
        if #o.Children == 0 then return 0 end
        
        if element.LayoutOrder == 1 then return 0 end

        local totalOffset = 0
        
        for i = 1, element.LayoutOrder - 1 do
            local currentItem = o.Children[i]
            if currentItem ~= nil then
                local _, _, _, itemY = currentItem:GetDrawingCoordinates(true)

                totalOffset = totalOffset + itemY + o.ListPadding
            end
            
        end

        return totalOffset
    end

    return o
end

return list