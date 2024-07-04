local list = {}
local guibase = require("yan.instance.ui.guibase")
list.__index = guibase

function list:New(o, screen)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)

    o.Type = "List"
    
    function o:GetYOffsetForListItem(element)
        if #o.Children == 0 then return 0 end
        
        if element.LayoutOrder == 1 then return 0 end

        local totalOffset = 0
        
        for i = 1, element.LayoutOrder - 1 do
            local currentItem = o.Children[i]
            local _, _, _, itemY = currentItem:GetDrawingCoordinates(true)

            totalOffset = totalOffset + itemY
        end

        print(element.Name, totalOffset)

        return totalOffset
    end

    return o
end

return list