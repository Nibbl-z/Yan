local dropdown = {}
local guibase = require("yan.instance.ui.guibase")
local UIVector2 = require("yan.datatypes.uivector2")
local UIVector = require("yan.datatypes.uivector")
local Scrollable = require("yan.instance.ui.scrollable")
local List = require("yan.instance.ui.list")
local Vector2 = require("yan.datatypes.vector2")
local Color = require("yan.datatypes.color")
dropdown.__index = guibase
function dropdown:New(screen, defaultElement, elementList)
    local o = guibase:New(nil, screen)

    o.Type = "Dropdown"
    o.DefaultElement = defaultElement
    o.ElementList = {}
    o.CornerRoundness = 0
    
    o.IsOpened = true
    o.ItemsScrollable = Scrollable:New(nil, screen, "vertical")
    o.ItemsList = List:New(nil, screen, 5, "center", "vertical")
    
    --o.ItemsScrollable.Parent = o
    o.ItemsList.Parent = o.ItemsScrollable
    o.ItemsScrollable.MaskChildren = true
    o.ItemsScrollable.Visible = false
    o.ItemsList.Visible = false
    o.ItemsScrollable.ScrollSize = UIVector.new(3,0)
    o.DropdownSize = UIVector.new(0.4, 0)

    o.ItemsScrollable.ZIndex = o.ZIndex + 1
    o.ItemsList.ZIndex = o.ZIndex + 2
    o.ItemsList.Color = Color.new(0,0,0,0)
    
    for _, element in ipairs(elementList) do
        table.insert(o.ElementList, element)
        
        element.Parent = o.ItemsList
    end
    
    function o:AddToElementList(element)
        table.insert(o.ElementList, element)

        element.Parent = o.ItemsList
    end
    
    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        if o.IsOpened then
            if defaultElement ~= nil then
                defaultElement.Size = UIVector2.new(0, sX, 0, sY)
                defaultElement.Position = UIVector2.new(0, pX, 0, pY)
                defaultElement.ZIndex = o.ZIndex + 1
            end

            o.ItemsScrollable.Visible = true
            o.ItemsList.Visible = true
            
            o.ItemsScrollable.Position = UIVector2.new(0, pX, 0, pY + sY)
            
            o.ItemsScrollable.Size = UIVector2.new(0, sX, o.DropdownSize.Scale, o.DropdownSize.Offset)

        else
            o.ItemsScrollable.Visible = false
            o.ItemsList.Visible = false
            if defaultElement ~= nil then
                defaultElement.Size = UIVector2.new(0, sX, 0, sY)
                defaultElement.Position = UIVector2.new(0, pX, 0, pY)
                defaultElement.ZIndex = o.ZIndex + 1
            end
        end
        
        love.graphics.setColor(1,1,1,1)
    end

    return o
end

return dropdown