local textinput = {}
local guibase = require("yan.instance.ui.guibase")
textinput.__index = guibase

local utf8 = require("utf8")

function textinput:New(o, screen, placeholderText, textSize)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.PlaceholderText = placeholderText
    o.Text = ""
    o.IsTyping = false
    o.TextSize = textSize
    o.Type = "TextInput"
    
    o.Font = love.graphics.newFont(o.TextSize)
    
    o.TextColor = {
        R = 1, G = 1, B = 1, A = 1
    }

    function o:TextInput(t)
        if o.IsTyping == false then return end

        o.Text = o.Text..t
        print(o.Text)
    end

    function o:KeyPressed(key)
        if o.IsTyping == false then return end

        if key == "backspace" then
            local byteoffset = utf8.offset(o.Text, -1)
    
            if byteoffset then
                o.Text = string.sub(o.Text, 1, byteoffset - 1)
            end
        end
    end
    
    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        
        love.graphics.rectangle("fill", pX, pY, sX, sY, 0, 0)
        
        love.graphics.setFont(o.Font)
        love.graphics.setColor(o.TextColor.R, o.TextColor.G, o.TextColor.B, o.TextColor.A)
        
        if o.IsTyping then
            love.graphics.printf(
            o.Text .. "|", 
            pX,
            pY,
            sX
        )
        else
            love.graphics.printf(
            o.Text, 
            pX,
            pY,
            sX
        )
        end
        
        
        love.graphics.setColor(1,1,1,1)
    end

    return o
end

return textinput