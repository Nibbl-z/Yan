local screen = {}
local instance = require("yan.instance.instance")
screen.__index = instance

local utils = require("yan.utils")
local uimanager = require("yan.uimanager")

function screen:New(o)
    o = o or instance:New(o)
    setmetatable(o, self)
    
    o.Type = "Screen"
    o.Enabled = false
    o.Elements = {}
    o.ZIndex = 1

    o.KeyboardInput = false

    function o:AddElement(element)
        table.insert(o.Elements, element)
    end
    
    local hovered = {}
    local clicked = {}
    
    function o:Update()
        local mX, mY = love.mouse.getPosition()
        local isDown = love.mouse.isDown(1)
        
        for _, element in ipairs(o.Elements) do
            if element.Type == "TextButton" or element.Type == "ImageButton" or element.Type == "TextInput" then
                local pX, pY, sX, sY = element:GetDrawingCoordinates()
                
                if utils:CheckCollision(mX, mY, 1, 1, pX, pY, sX, sY) then
                    if utils:TableFind(hovered, element) == false then
                        if element.MouseEnter ~= nil then
                            element.MouseEnter()
                        end
                        
                        if element.MouseEnterDefault ~= nil then
                            element.MouseEnterDefault()
                        end
                        
                        table.insert(hovered, element)
                    end
                    
                    if utils:TableFind(clicked, element) == false then
                        if isDown then
                            if element.MouseDown ~= nil then
                                element.MouseDown()
                                if element.Type == "TextInput" then
                                    element.IsTyping = true
                                end
                                
                                table.insert(clicked, element)
                            end

                            if element.MouseDownDefault ~= nil then
                                element.MouseDownDefault()

                                if element.Type == "TextInput" then
                                    element.IsTyping = true
                                end
                                
                                if element.MouseDown == nil then table.insert(clicked, element) end
                            end
                        end
                    elseif utils:TableFind(clicked, element) ~= false then
                        if not isDown then
                            if element.MouseUpDefault ~= nil then
                                element.MouseUpDefault()
                            end

                            if element.MouseUp ~= nil then
                                element.MouseUp()
                            end

                            
                            
                            if element.MouseEnter ~= nil then
                                element.MouseEnter()
                            end

                            if element.MouseEnterDefault ~= nil then
                                element.MouseEnterDefault()
                            end
                            
                            table.remove(clicked, utils:TableFind(clicked, element))
                        end
                    end
                else
                    if utils:TableFind(hovered, element) ~= false then
                        if utils:TableFind(clicked, element) ~= false then
                            if element.MouseUpDefault ~= nil then
                                element.MouseUpDefault()
                            end

                            if element.MouseUp ~= nil then
                                element:MouseUp()
                                table.remove(clicked, utils:TableFind(clicked, element))
                            end

                            
                        end

                        if element.MouseLeave ~= nil then
                            element.MouseLeave()
                        end

                        if element.MouseLeaveDefault ~= nil then
                            element.MouseLeaveDefault()
                        end
                        
                        table.remove(hovered, utils:TableFind(hovered, element))
                    end
                    
                    if isDown and element.Type == "TextInput" then
                        element.IsTyping = false
                    end
                end
            end
        end
    end
    
    function o:TextInput(t)
        for _, element in ipairs(o.Elements) do
            if element.Type == "TextInput" then
                element:TextInput(t)
            end
        end
    end

    function o:KeyPressed(key, scancode, rep)
        for _, element in ipairs(o.Elements) do
            if element.Type == "TextInput" then
                element:KeyPressed(key, scancode, rep)
            end
        end
    end
    
    function o:Draw()
        if o.Enabled == false then return end
        if o.SceneEnabled == false then return end
        
        local elements = o.Elements
        table.sort(elements, function(a,b) 
            return (a.ZIndex or 0) < (b.ZIndex or 0) 
        end)

        for _, element in ipairs(elements) do
            element:Draw()
        end
    end

    uimanager:AddScreen(o)
    
    return o
end

return screen