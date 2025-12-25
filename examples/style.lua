require "yan"

return function (page)
    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 5
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 5: styling",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "yan provides some simple styling properties, including rounded corners and outlines!", 
                backgroundcolor = Color.new(1,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            container = uibase:new {
                size = UDim2.new(1,0,0.7,0),
                position = UDim2.new(0,0,0.3,0),
                backgroundcolor = Color.new(0,0,0,0),
                leftpadding = UDim.new(0,20),
                rightpadding = UDim.new(0,20),
                toppadding = UDim.new(0,20),
                bottompadding = UDim.new(0,20),
                children = {
                    frame = uibase:new {
                        size = UDim2.new(0.4,0,0.4,0),
                        cornerradius = UDim.new(0,10),
                        bordercolor = Color.new(1,0.5,1),
                        backgroundcolor = Color.new(0.5,0,0.5),
                        bordersize = 5,
                    },
                    label = textlabel:new {
                        size = UDim2.new(0.5,0,0.5,0),
                        position = UDim2.new(1,0,1,0),
                        anchorpoint = Vector2.new(1,1),
                        backgroundcolor = Color.new(0.5,0.5,0.5,1),
                        textcolor = Color.new(1,1,1,1),
                        textborder = Color.new(0,0,0,1),
                        textsize = 30,
                        text = "look at my text border!!"
                    }
                }
            }
        }
    }
end