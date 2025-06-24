require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    testscreen = screen:new()

    testui = uibase:new()
    testui.position = UDim2.new(0.25, 0, 0.25, 0)
    testui.size = UDim2.new(0.5, 0, 0.5, 0)
    testui.clipdescendants = true

    testui:applyallpadding(UDim.new(0.1, 0))
    
    testlabel = textlabel:new("hai world!!!", 25, "center", "center")
    testlabel.position = UDim2.new(0, 0, 0, 0)
    testlabel.size = UDim2.new(1,0,0.5,0)
    testlabel.backgroundcolor = Color.new(1,0,0,0.5)
    testlabel:setparent(testui)
    testlabel.zindex = 5
    
    testlabel2 = textlabel:new("hai world!!! 2", 25, "center", "center")
    testlabel2.position = UDim2.new(0, 0, 0.5, 0)
    testlabel2.size = UDim2.new(1,0,0.5,0)
    testlabel2.backgroundcolor = Color.new(1,0,0,0.5)
    testlabel2:setparent(testui)
    testlabel2.zindex = 5
    
    testui2 = uibase:new()
    testui2.position = UDim2.new(0.2, 0, 0.2, 0)
    testui2.size = UDim2.new(1, 0, 1, 0)
    testui2.backgroundcolor = Color.new(0,1,0,0.5)
    testui2:setparent(testlabel)
    testui2.zindex = -5

    testimage = imagelabel:new("examples/example_image.png")
    testimage.size = UDim2.new(0, 150, 0, 150)
    testimage.position = UDim2.new(1, -10, 1, -10)
    testimage.anchorpoint = Vector2.new(1, 1)
    
    testimage2 = imagelabel:new("examples/example_image_2.png")
    testimage2.size = UDim2.new(0, 150, 0, 150)
    testimage2.position = UDim2.new(0.5, 0, 1, -10)
    testimage2.anchorpoint = Vector2.new(0.5, 1)
    
    testui.mouseenter = function()
        testui.backgroundcolor = Color.new(1, 0, 1, 1)
    end
    
    testui.mouseexit = function()
        testui.backgroundcolor = Color.new(1,1,1,1)
    end

    testui.mousebutton1down = function ()
        testui.backgroundcolor = Color.new(0, 1, 1, 1)
    end

    testui.mousebutton1up = function()
        testui.backgroundcolor = Color.new(1, 0, 1, 1)
    end
    
    testscreen:addelements({testui, testlabel, testui2, testimage, testimage2, testlabel2})
end

function love.update()
    testscreen:update()
end

function love.draw()
    testscreen:draw()
end