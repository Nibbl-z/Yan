require "yan"

return function (page)
    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 3
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 3: text inputs",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "textinputs are special elements that you can type text into! it uses love.textinput, which means that you can hold shift for special characters and stuff, like you'd expect any text input to do normally :P", 
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
                    input = textinput:new {
                        size = UDim2.new(1,0,0.15,0),
                    },
                    input2 = textinput:new {
                        position = UDim2.new(0,0,0.2,0),
                        size = UDim2.new(1,0,0.15,0),
                    },
                    label = textlabel:new {
                        text = function(self)
                            if self.parent == nil then return "" end
                            local input = self.parent:get("input")

                            return "the same text but in red to show that you can access the text from the textinput :P -> "..input.text
                        end,
                        position = UDim2.new(0,0,0.5,0),
                        size = UDim2.new(1,0,0.4,0),
                        textcolor = Color.new(1,0,0,1)
                    }
                }
            }
        }
    }
end