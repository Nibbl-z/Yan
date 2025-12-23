require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})

    img = imagelabel:new {
        image = "examples/example_btn.png",
        zindex = 10
    }

    value = 0

    mainScreen = screen:new {
        container = uibase:new {
            position = function ()
                return UDim2.new(math.sin(value) / 4 + 0.25, 0, 0.5, 0)
            end,
            size = UDim2.new(0.5,0,0.5,0),
            anchorpoint = Vector2.new(0, 0.5),
            backgroundcolor = Color.new(1,0,1,1),
            children = {
                helloworld = textlabel:new {
                    size = UDim2.new(0.5,0,0.5,0),
                    text = "hello world :3",
                },
            },
            mouseenter = function (self)
                self.backgroundcolor = Color.new(0.5,0,0.5)
            end,
            mouseexit = function (self)
                self.backgroundcolor = Color.new(1,0,1)
            end
        },

        input = textinput:new {
            position = UDim2.new(0, 10, 0, 10),
            size = UDim2.new(1, -20, 0.1, 0)
        }
    }

    print(mainScreen:get("container"):get("helloworld").text)
end


function love.draw()
    yan:draw()
end


function love.update(dt)
    value = value + dt * 1
    yan:update()
end

function love.textinput(text)
    yan:textinput(text)
end

function love.keypressed(key)
    yan:keypressed(key)
    img.image = "examples/example_image.png"
end