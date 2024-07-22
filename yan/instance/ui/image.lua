local imagebutton = {}
local guibase = require("yan.instance.ui.guibase")
imagebutton.__index = guibase

function imagebutton:New(o, screen, image)
    o = o or guibase:New(o, screen)
    setmetatable(o, self)
    
    o.Type = "Image"
    o.Image = love.graphics.newImage(image)
    o.CornerRoundness = 16

    function o:Draw()
        
        local pX, pY, sX, sY = o:GetDrawingCoordinates()
        
        local function stencilFunc()
            o:Stencil()
            love.graphics.rectangle("fill", pX, pY, sX, sY, o.CornerRoundness, o.CornerRoundness)
        end
        
        love.graphics.stencil(stencilFunc, "replace", 1)
        
        love.graphics.setStencilTest("greater", 0)
        love.graphics.setColor(o.Color.R, o.Color.G, o.Color.B, o.Color.A)
        love.graphics.draw(o.Image, pX, pY, 0, sX / o.Image:getPixelWidth(), sY / o.Image:getPixelHeight())
        
        love.graphics.setColor(1,1,1,1)
        
        love.graphics.setStencilTest()
    
        
    end

    return o
end

return imagebutton