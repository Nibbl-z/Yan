require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    testui = uibase:new()
    testui.position = UDim2.new(0.25, 0, 0.25, 0)
    testui.size = UDim2.new(0.5, 0, 0.5, 0)
    
    testlabel = textlabel:new("hai world!!!", 25, "center", "center")
    testlabel.position = UDim2.new(0, 10, 0, 10)
    testlabel.size = UDim2.new(1,-20,0.5,0)
    testlabel.backgroundcolor = Color.new(1,0,0,0.5)
    testlabel:setparent(testui)

    testui2 = uibase:new()
    testui2.position = UDim2.new(0.2, 0, 0.2, 0)
    testui2.size = UDim2.new(1, 0, 1, 0)
    testui2.backgroundcolor = Color.new(0,1,0,0.5)
    testui2:setparent(testlabel)
end

function love.update()
    
end

function love.draw()
    testui:draw()
    testlabel:draw()
    testui2:draw()
end