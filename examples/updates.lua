require "yan"

return function (page)
    local x = 0
    local clicks = 0

    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 4
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 4: update functions",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "all element properties (except parent or children or events) can be set to a function to make them auto-update in love.update! the value that the function returns is what the value is set to every frame!", 
                backgroundcolor = Color.new(1,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            container = uibase:new {
                size = UDim2.new(1,0,0.7,0),
                position = UDim2.new(0,0,0.3,0),
                backgroundcolor = Color.new(0,0,0,0),
                leftpadding = UDim.new(0,5),
                rightpadding = UDim.new(0,5),
                toppadding = UDim.new(0,5),
                bottompadding = UDim.new(0,5),
                children = {
                    counter = textlabel:new {
                        size = UDim2.new(0.4,0,0.5,0),
                        position = function (self, dt)
                            x = x + dt * 3
                            return UDim2.new(0, 0, (math.sin(x) + 1) / 4, 0)
                        end,
                        text = function ()
                            return "i'm moving on a sine wave thanks to the update function! plus i can tell you that you've clicked the button over there "..tostring(clicks).." times!"
                        end
                    },

                    button2 = imagelabel:new {
                        image = "examples/example_btn.png",
                        position = UDim2.new(0.9,0,0.5,0),
                        anchorpoint = Vector2.new(1,0.5),
                        size = UDim2.new(0,150,0,150),

                        mousebutton1down = function (self)
                            self.image = "examples/example_btn_clicked.png"
                        end,

                        mousebutton1up = function (self)
                            self.image = "examples/example_btn.png"
                            clicks = clicks + 1
                        end,

                        mouseexit = function (self)
                            self.image = "examples/example_btn.png"
                        end,
                    }
                }
            }
        }
    }
end