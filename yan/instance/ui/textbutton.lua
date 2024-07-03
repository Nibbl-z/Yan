local textbutton = {}
local guibase = require("yan.instance.ui.guibase")
textbutton.__index = guibase

function textbutton:New(o, screen, text, textSize, align)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "TextButton"
    o.Text = text
    o.TextSize = textSize
    o.Align = align

    o.Font = love.graphics.newFont(o.TextSize)
    
    o.ButtonColor = {
        R = 0,
        G = 0,
        B = 0,
        A = 1
    }
    
    function o:SetButtonColor(r, g, b, a)
        o.ButtonColor = {
            R = r, G = g, B = b, A = a
        }
    end

    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        love.graphics.setColor(o.ButtonColor.R, o.ButtonColor.G, o.ButtonColor.B, o.ButtonColor.A)

        love.graphics.rectangle("fill", pX, pY, sX, sY, 5, 5)
        
        love.graphics.setFont(o.Font)
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)

        love.graphics.printf(
            o.Text, 
            pX,
            pY,
            sX, 
            o.Align
        )
        
        love.graphics.setColor(1,1,1,1)
    end

    return o
end

return textbutton