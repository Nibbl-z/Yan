local slider = {}
local guibase = require("yan.instance.ui.guibase")
local Color = require("yan.datatypes.color")
local UIVector2 = require("yan.datatypes.uivector2")
local utils = require("yan.utils")

slider.__index = guibase

function slider:New(screen, minValue, maxValue)
    local o = guibase:New(nil, screen)
    o.Type = "Slider"
    o.Progress = 0.5
    o.Value = minValue
    o.CornerRoundness = 8
    
    o.SliderColor = Color.new(0.7,0.7,0.7,0.5)
    o.SliderSize = UIVector2.new(0,100,1,0)
    
    

    o.WasSliding = false

    function o.Slide(mX, mY)
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        o.Progress = utils:Clamp((mX - pX) / sX, 0.0, 1.0)
        o.Value = minValue + (maxValue - minValue) * o.Progress
        print(o.Value)
    end

    function o:Draw()
        local mX, mY = love.mouse.getPosition()
        local pX, pY, sX, sY = o:GetDrawingCoordinates()

        if love.mouse.isDown(1) and (utils:CheckCollision(mX, mY, 1, 1, pX, pY, sX, sY) or o.WasSliding) then
            o.WasSliding = true
            o.Slide(mX, mY)
        end

        if not love.mouse.isDown(1) then
            o.WasSliding = false
        end
        
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)        
        love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        
        love.graphics.setColor(o.SliderColor.R, o.SliderColor.G, o.SliderColor.B, o.SliderColor.A)
        love.graphics.rectangle("fill", pX + ((sX - o.SliderSize.XOffset) * o.Progress), pY, o.SliderSize.XOffset, sY, o.CornerRoundness, o.CornerRoundness)
    end
    
    return o
end

return slider