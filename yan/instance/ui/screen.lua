local screen = {}
local instance = require("yan.instance.instance")
screen.__index = instance

local utils = require("yan.utils")

function screen:New(o)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Type = "Screen"
    o.Enabled = false
    o.Elements = {}

    function o:AddElement(element)
        table.insert(o.Elements, element)
    end
    
    local hovered = {}
    local clicked = {}
    
    function o:Update()
        local mX, mY = love.mouse.getPosition()
        local isDown = love.mouse.isDown(1)
        
        for _, element in ipairs(o.Elements) do
            if element.Type == "TextButton" then
                local pX, pY, sX, sY = element:GetDrawingCoordinates()
                
                if utils:CheckCollision(mX, mY, 1, 1, pX, pY, sX, sY) then
                    if utils:TableFind(hovered, element) == false then
                        if element.MouseEnter ~= nil then
                            element.MouseEnter()
                        end
                        
                        table.insert(hovered, element)
                    end

                    if utils:TableFind(clicked, element) == false then
                        if isDown then
                            if element.MouseDown ~= nil then
                                element.MouseDown()

                                table.insert(clicked, element)
                            end
                        end
                    elseif utils:TableFind(clicked, element) ~= false then
                        if not isDown then
                            if element.MouseUp ~= nil then
                                element.MouseUp()

                                if element.MouseEnter ~= nil then
                                    element.MouseEnter()
                                end
                                
                                table.remove(clicked, utils:TableFind(clicked, element))
                            end
                        end
                    end
                else
                    if utils:TableFind(hovered, element) ~= false then
                        if utils:TableFind(clicked, element) ~= false then
                            if element.MouseUp ~= nil then
                                element:MouseUp()
                                table.remove(clicked, utils:TableFind(clicked, element))
                            end
                        end

                        if element.MouseLeave ~= nil then
                            element.MouseLeave()
                        end
                        
                        table.remove(hovered, utils:TableFind(hovered, element))
                    end
                end
            end
        end

        
    end

    function o:Draw()
        if o.Enabled == false then return end

        local elements = o.Elements
        table.sort(elements, function(a,b) 
            return (a.ZIndex or 0) < (b.ZIndex or 0) 
        end)

        for _, element in ipairs(elements) do
            element:Draw()
        end
    end
    
    return o
end

return screen