require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})

    
end


function love.draw()
    yan:draw()
end

function love.update(dt)
    yan:update(dt)
end

function love.textinput(text)
    yan:textinput(text)
end

function love.keypressed(key)
    yan:keypressed(key)
end