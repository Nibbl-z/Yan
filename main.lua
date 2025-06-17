require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    testscreen = screen:new()

    testui = uibase:new()
    testui.position = UDim2.new(0.25, 0, 0.25, 0)
    testui.size = UDim2.new(0.5, 0, 0.5, 0)
    
    testlabel = textlabel:new("hai world!!!", 25, "center", "center")
    testlabel.position = UDim2.new(0, 10, 0, 10)
    testlabel.size = UDim2.new(1,-20,0.5,0)
    testlabel.backgroundcolor = Color.new(1,0,0,0.5)
    testlabel:setparent(testui)
    testlabel.zindex = 5
    
    testui2 = uibase:new()
    testui2.position = UDim2.new(0.2, 0, 0.2, 0)
    testui2.size = UDim2.new(1, 0, 1, 0)
    testui2.backgroundcolor = Color.new(0,1,0,0.5)
    testui2:setparent(testlabel)
    testui2.zindex = -5
    
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
    
    testscreen:addelements({testui, testlabel, testui2})
end

function love.update()
    testscreen:update()
end

function love.draw()
    testscreen:draw()
end