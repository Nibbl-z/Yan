local slider = {}
local guibase = require("yan.instance.ui.guibase")
local Color = require("yan.datatypes.color")
local UIVector2 = require("yan.datatypes.uivector2")
slider.__index = guibase

function slider:New(screen, minValue, maxValue)
    local o = guibase:New(nil, screen)
    o.Type = "Slider"
    o.Progress = 0.5
    o.Value = minValue
    
    o.SliderColor = Color.new(0.7,0.7,0.7,0.5)
    o.SliderSize = UIVector2.new(0,25,1,0)
    
    function o.Slide(mX, mY)
        
    end

    function o:Draw()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)        
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        love.graphics.setColor(o.SliderColor.R, o.SliderColor.G, o.SliderColor.B, o.SliderColor.A)
        love.graphics.rectangle("fill", pX + ((sX - o.SliderSize.XOffset) * o.Progress), pY, o.SliderSize.XOffset, sY, o.CornerRoundness, o.CornerRoundness)
    end
    
    return o
end

return slider