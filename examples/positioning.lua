require "yan"

return function (page)
    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 1
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 1: positioning & parenting & padding",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "ui elements are positioned and sized based on scale (screen or parent size) and offset (pixels), as well as anchor points, which by default is the top left corner (0,0). this makes it very easy to position ui elements! there's also padding, which insets all child elements", 
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
                    label = textlabel:new {
                        text = "this has 0.5x0.5 size in scale, and my container has 5px of padding, and the niko in the corner has 80x80 size in offset with (1,1) anchor point",
                        size = UDim2.new(0.5, 0, 0.5, 0)
                    },

                    niko = imagelabel:new {
                        image = "examples/example_image.png",
                        position = UDim2.new(1,0,1,0),
                        size = UDim2.new(0,80,0,80),
                        anchorpoint = Vector2.new(1,1),
                    }
                }
            }
        }
    }
end