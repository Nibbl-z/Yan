require "yan"

return function (page)
    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 2
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 2: interactivity/buttons",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "any element can be made interactable by passing in a function to the mouseenter, mouseexit, or mousebutton(1/2)(up/down) parameters!", 
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
                    button1 = textlabel:new {
                        size = UDim2.new(0.5, 0, 0.2, 0),
                        position = UDim2.new(0.5,0,0,0),
                        anchorpoint = Vector2.new(0.5, 0),
                        text = "click mee!!",

                        mouseenter = function(self)
                            self.backgroundcolor = Color.new(0.7,0.7,0.7,1)
                        end,

                        mouseexit = function(self)
                            self.backgroundcolor = Color.new(1,1,1,1)
                            self.text = "click mee!!"
                        end,

                        mousebutton1down = function (self)
                            self.backgroundcolor = Color.new(0.2,1,0.2,1)
                            self.text = "ty :D"
                        end,

                        mousebutton1up = function (self)
                            self.backgroundcolor = Color.new(0.7,0.7,0.7,1)
                            self.text = "click mee!!"
                        end,

                        mousebutton2down = function (self)
                            self.backgroundcolor = Color.new(1,0.2,0.2,1)
                            self.text = "a right click?!!"
                        end,

                        mousebutton2up = function (self)
                            self.backgroundcolor = Color.new(0.7,0.7,0.7,1)
                            self.text = "click mee!!"
                        end
                    },

                    button2 = imagelabel:new {
                        image = "examples/example_btn.png",
                        position = UDim2.new(0.5,0,0.5,0),
                        anchorpoint = Vector2.new(0.5,0.5),
                        size = UDim2.new(0,150,0,150),

                        mousebutton1down = function (self)
                            self.image = "examples/example_btn_clicked.png"
                        end,

                        mousebutton1up = function (self)
                            self.image = "examples/example_btn.png"
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