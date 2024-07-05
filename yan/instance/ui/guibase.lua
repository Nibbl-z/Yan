local guiBase = {}
local instance = require("yan.instance.instance")
guiBase.__index = instance

local utils = require("yan.utils")

function guiBase:New(o, screen)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Type = "GuiBase"
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

    o.Padding = {
        XOffset = 0,
        XScale = 0,
        YOffset = 0,
        YScale = 0
    }

    o.AnchorPoint = {X = 0, Y = 0}
    o.ZIndex = 1
    o.LayoutOrder = 1
    
    o.Children = {}
    o.Parent = nil
    
    screen:AddElement(o)
    
    function o:GetDrawingCoordinates(ignoreYOffset)
        local sizeWidth = love.graphics.getWidth()
        local sizeHeight = love.graphics.getHeight()
        local pXOffset = 0
        local pYOffset = 0

        if o.Parent ~= nil then
            pXOffset, pYOffset, sizeWidth, sizeHeight = o.Parent:GetDrawingCoordinates()
            
            
            
            if o.Parent.Type == "List" and ignoreYOffset ~= true then
                pYOffset = pYOffset + o.Parent:GetYOffsetForListItem(o)
                
                if o.Parent.Align == "center" then
                    pXOffset = pXOffset + ((o.Size.XScale * sizeWidth + o.Size.XOffset) * 0.5) 
                elseif o.Parent.Align == "right" then
                    pXOffset = pXOffset + ((o.Size.XScale * sizeWidth + o.Size.XOffset)) 
                end
            end

            pXOffset = pXOffset + o.Parent.Padding.XOffset + (sizeWidth * o.Parent.Padding.XScale)
            pYOffset = pYOffset + o.Parent.Padding.YOffset + (sizeHeight * o.Parent.Padding.YScale)
            
            sizeWidth = sizeWidth - (o.Parent.Padding.XOffset + (sizeWidth * o.Parent.Padding.XScale)) * 2
            sizeHeight = sizeHeight - (o.Parent.Padding.YOffset + (sizeHeight * o.Parent.Padding.YScale)) * 2
        end

        
        
        local sX = o.Size.XScale * sizeWidth + o.Size.XOffset
        local sY = o.Size.YScale * sizeHeight + o.Size.YOffset
        
        local pX = (o.Position.XScale * sizeWidth - sX * o.AnchorPoint.X) + o.Position.XOffset + pXOffset
        local pY = (o.Position.YScale * sizeHeight - sY * o.AnchorPoint.Y) + o.Position.YOffset + pYOffset
        
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

    function o:SetPadding(xS, xO, yS, yO)
        o.Padding = {
            XOffset = xO,
            XScale = xS,
            YOffset = yO,
            YScale = yS
        }
    end
    
    function o:SetParent(element)

        table.insert(element.Children, o)
        
        o.Parent = element
    end

    function o:GetChild(elementName)
        for i, child in pairs(o.Children) do
            if child.Parent ~= o then
                table.remove(i, o.Children)
            end
            
            if child.Name == elementName then
                return child
            end
        end
        
        return nil
    end
    
    function o:GetAncestor(elementName)
        if o.Parent.Name == elementName then
            return o.Parent
        else
            return o.Parent:GetAncestor(elementName)
        end
    end
    
    function o:GetDescendant(elementName)
        if #o.Children == 0 then return nil end

        for i, child in ipairs(o.Children) do
            if child.Parent ~= o then
                table.remove(i, o.Children)
            end
            if child.Name == elementName then
                return child
            else
                local dillyDally = child:GetDescendant(elementName) -- thanks josh for giving me this awesome variable name, i appreciate it
                
                if dillyDally ~= nil then
                    return dillyDally
                end
            end
        end
        
        
    end

    return o
end

return guiBase