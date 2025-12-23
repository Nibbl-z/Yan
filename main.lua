require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    thing = uibase:new {
        position = UDim2.new(0, 10, 0.5, 0)
    }

    img = imagelabel:new {
        image = "examples/example_btn.png",
        zindex = 10
    }

    mainScreen = screen:new {
        uibase:new {
            position = UDim2.new(0.5, 0, 0.5, 0),
            anchorpoint = Vector2.new(0.5, 0.5),
            backgroundcolor = Color.new(1,0,1,1)
        },

        textlabel:new {
            position = UDim2.new(0,10,0,10),
            text = "hello world :3",
        },

        textinput:new {
            position = UDim2.new(0, 10, 0.9, 0),
            size = UDim2.new(0.5,0,0.1,0)
        },

        img
    }
end

function love.draw()
    mainScreen:draw()
end

function love.update()
    mainScreen:update()
end

function love.textinput(text)
    mainScreen:textinput(text)
end

function love.keypressed(key)
    mainScreen:keypressed(key)
    img.image = "examples/example_image.png"
end