require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})

    img = imagelabel:new {
        image = "examples/example_image.png",
        zindex = 10
    }
    tween = tween:new(img, TweenInfo.new(3, EasingStyle.BounceOut), {
        position = UDim2.new(1, 0, 1, 0), 
        backgroundcolor = Color.new(1,0,0,1),
        anchorpoint = Vector2.new(1,1),
        size = UDim2.new(0,200,0,200)
    })

    value = 0

    mainScreen = screen:new {
        -- container = uibase:new {
        --     position = function ()
        --         return UDim2.new(math.sin(value) / 4 + 0.25, 0, 0.5, 0)
        --     end,
        --     size = UDim2.new(0.5,0,0.5,0),
        --     anchorpoint = Vector2.new(0, 0.5),
        --     backgroundcolor = Color.new(1,0,1,1),
        --     cornerradius = UDim.new(0, 10),
        --     bordersize = 5,
        --     bordercolor = Color.new(0.7, 0, 0.7),
        --     layout = "list",
        --     listpadding = 20,
        --     listdirection = "horizontal",
        --     listhalign = "right",
        --     listvalign = "center",
        --     children = {
        --         helloworld = textlabel:new {
        --             size = UDim2.new(0.1,0,0.5,0),
        --             text = "hello world :3",
        --             textcolor = Color.new(1,1,1,1),
        --             backgroundcolor = Color.new(0.3,0.3,0.3,1),
        --             textborder = Color.new(0,0,0,1),
        --             cornerradius = UDim.new(1, 0)
        --         },
        --         helloworld2 = textlabel:new {
        --             size = UDim2.new(0.2,0,0.5,0),
        --             text = "hello world :3",
        --             textcolor = Color.new(1,1,1,1),
        --             backgroundcolor = Color.new(0.3,0.3,0.3,1),
        --             textborder = Color.new(0,0,0,1),
        --             cornerradius = UDim.new(1, 0)
        --         },
        --         helloworld3 = textlabel:new {
        --             size = UDim2.new(0,100,0,200),
        --             text = "hello world :3",
        --             textcolor = Color.new(1,1,1,1),
        --             backgroundcolor = Color.new(0.3,0.3,0.3,1),
        --             textborder = Color.new(0,0,0,1),
        --             cornerradius = UDim.new(1, 0)
        --         },
        --     },
        --     mouseenter = function (self)
        --         self.backgroundcolor = Color.new(0.5,0,0.5)
        --     end,
        --     mouseexit = function (self)
        --         self.backgroundcolor = Color.new(1,0,1)
        --     end
        -- },

        -- input = textinput:new {
        --     position = UDim2.new(0, 10, 0, 10),
        --     size = UDim2.new(1, -20, 0.1, 0),
        --     textborder = Color.new(1,0,0)
        -- },

        image = img
    }

    --print(mainScreen:get("container"):get("helloworld").text)
end


function love.draw()
    yan:draw()
end


function love.update(dt)
    value = value + dt * 1
    yan:update(dt)
end

function love.textinput(text)
    yan:textinput(text)
end

function love.keypressed(key)
    yan:keypressed(key)

    if key == "r" then
        tween:pause()
    elseif key == "s" then
        tween:cancel()
    else
        tween:play()
    end
end