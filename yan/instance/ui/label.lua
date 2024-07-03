local label = {}
local guibase = require("yan.instance.ui.guibase")
label.__index = guibase

function label:New(o, screen, text, textSize, align)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Text = text
    o.TextSize = textSize
    o.Align = align

    o.Font = love.graphics.newFont(o.TextSize)
    
    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
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

return label