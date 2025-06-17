require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    testui = uibase:new()
    testui.position = UDim2.new(0.25, 0, 0.25, 0)
    testui.size = UDim2.new(0.5, 0, 0.5, 0)
    
    testlabel = textlabel:new("hai world!!!", 50, "center", "center")
    testlabel.position = UDim2.new(0, 10, 0, 10)
    testlabel.size = UDim2.new(1,0,0.25,0)
end

function love.update()
    
end

function love.draw()
    testui:draw()
    testlabel:draw()
end