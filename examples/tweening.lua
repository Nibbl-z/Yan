require "yan"

return function (page)
    local tween1, tween2
    local button1 = textlabel:new {
        size = UDim2.new(0.4,0,0.3,0),
        text = "left click me and i'll bounce down to the bottom! right click me to cancel/reset the tween!",
        mousebutton1up = function ()
            tween1:play()
        end,
        mousebutton2up = function ()
            tween1:cancel()
        end
    }

    local button2 = textlabel:new {
        size = UDim2.new(0.4,0,0.3,0),
        position = UDim2.new(0.5,0,0,0),
        text = "left click me and i'll do a repeating & reversing tween! right click me to cancel/reset the tween!",
        mousebutton1up = function ()
            tween2:play()
        end,
        mousebutton2up = function ()
            tween2:cancel()
        end
    }

    tween1 = tween:new(button1, TweenInfo.new(2, EasingStyle.BounceOut), {
        position = UDim2.new(0,0,1,0),
        anchorpoint = Vector2.new(0,1),
        backgroundcolor = Color.new(1,0,0,1)
    })

    tween2 = tween:new(button2, TweenInfo.new(1, EasingStyle.QuintInOut, true, 1), {
        position = UDim2.new(0.5,0,0.5,0),
        anchorpoint = Vector2.new(0,0.5),
        backgroundcolor = Color.new(0.2,0.2,0.2,1),
        size = UDim2.new(0.4,0,0.6,0),
        textcolor = Color.new(0.5,0.5,1,1)
    })


    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 7
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 7: tweening",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "yan features a tweening system, which allows you to make smooth and animated ui easily! tweens can animate properties with a duration and an easing style, as well as other options such as repeat count, delay, or reversing", 
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
                    button1,
                    button2
                }
            }
        }
    }
end