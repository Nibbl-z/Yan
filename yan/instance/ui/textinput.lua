local textinput = {}
local guibase = require("yan.instance.ui.guibase")
textinput.__index = guibase

local utf8 = require("utf8")

function textinput:New(o, screen, placeholderText, textSize, align, verticalAlign, fontPath)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.PlaceholderText = placeholderText
    o.Text = ""
    o.IsTyping = false
    o.TextSize = textSize
    o.Type = "TextInput"
    o.Align = align
    o.VerticalAlign = verticalAlign
    o.CornerRoundness = 0
    
    if fontPath ~= nil then
        o.Font = love.graphics.newFont(fontPath, o.TextSize)
    else
        o.Font = love.graphics.newFont(o.TextSize)
    end
    
    o.TextColor = {
        R = 1, G = 1, B = 1, A = 1
    }

    o.PlaceholderTextColor = {
        R = 0.5, G = 0.5, B = 0.5, A = 1
    }

    function o:SetTextColor(r, g, b, a)
        o.TextColor = {
            R = r, G = g, B = b, A = a
        }
    end
    
    function o:SetPlaceholderTextColor(r, g, b, a)
        o.PlaceholderTextColor = {
            R = r, G = g, B = b, A = a
        }
    end
    
    function o:TextInput(t)
        if o.IsTyping == false then return end

        o.Text = o.Text..t
        print(o.Text)
    end

    function o:KeyPressed(key, scancode, rep)
        if o.IsTyping == false then
            love.keyboard.setKeyRepeat(false)
            return 
        end
        love.keyboard.setKeyRepeat(true)
        if key == "backspace" then

            local byteoffset = utf8.offset(o.Text, -1)
    
            if byteoffset then
                o.Text = string.sub(o.Text, 1, byteoffset - 1)
            end
        end

        if key == "return" then
            o.IsTyping = false

            if o.OnEnter ~= nil then
                o.OnEnter()
            end
        end
    end
    
    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        love.graphics.setFont(o.Font)
        
        local yOffset = 0
        
        if o.VerticalAlign == "center" then
            local _, lines = o.Font:getWrap(o.Text, sX)
            yOffset = sY * 0.5 - ((o.Font:getHeight() / 2) * #lines)
        elseif o.VerticalAlign == "bottom" then
            local _, lines = o.Font:getWrap(o.Text, sX)
            yOffset = sY * 1 - ((o.Font:getHeight()) * #lines)
        end
        
        if o.Text == "" and o.IsTyping == false then
            love.graphics.setColor(o.PlaceholderTextColor.R, o.PlaceholderTextColor.G, o.PlaceholderTextColor.B, o.PlaceholderTextColor.A)
            love.graphics.printf(
                o.PlaceholderText, 
                pX,
                pY + yOffset,
                sX,
                o.Align
            )
        else
            love.graphics.setColor(o.TextColor.R, o.TextColor.G, o.TextColor.B, o.TextColor.A)
            if o.IsTyping then
                love.graphics.printf(
                o.Text .. "|", 
                pX,
                pY + yOffset,
                sX,
                o.Align
            )
            else
                love.graphics.printf(
                o.Text, 
                pX,
                pY + yOffset,
                sX,
                o.Align
            )
            end
        end
        
        
        
        love.graphics.setColor(1,1,1,1)
    end

    return o
end

return textinput