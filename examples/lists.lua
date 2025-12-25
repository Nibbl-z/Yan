require "yan"

return function (page)
    return uibase:new {
        size = UDim2.new(1,0,1,0),
        backgroundcolor = Color.new(0,0,0,0),
        visible = function ()
            return page() == 6
        end,
        children = {
            title = textlabel:new {
                size = UDim2.new(1,0,0.1,0),
                textsize = 30,
                text = "demo 6: list layouts",
                backgroundcolor = Color.new(0,0,0,0),
                textcolor = Color.new(1,1,1,1)
            },
            desc = textlabel:new {
                size = UDim2.new(1,0,0.2,0),
                position = UDim2.new(0,0,0.1,0),
                halign = "center",
                valign = "top",
                text = "elements can be given the list layout property, which arranges the child elements in a list! you are able to change the direction of the list, the padding between items, and the horizontal/vertical alignment", 
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
                    horizontal = uibase:new {
                        layout = "list",
                        size = UDim2.new(1,0,0.4,0),
                        listdirection = "horizontal",
                        listpadding = 5,
                        listhalign = "center",
                        listvalign = "center",
                        backgroundcolor = Color.new(0.5,0.5,0.5,1),
                        children = {
                            one = textlabel:new {
                                size = UDim2.new(0,80,0,80),
                                text = "this one is:",
                                textsize = 15,
                            },
                            two = textlabel:new {
                                size = UDim2.new(0,110,0,110),
                                text = "horizontal!",
                                textsize = 15,
                            },
                            three = textlabel:new {
                                size = UDim2.new(0,90,0,90),
                                text = "with all centered alignment and some padding!",
                                textsize = 15,
                            }
                        }
                    },

                    vertical = uibase:new {
                        position = UDim2.new(0,0,0.4,20),
                        size = UDim2.new(1,0,0.6,-20),
                        backgroundcolor = Color.new(0.3,0.3,0.3,1),
                        layout = "list",
                        listdirection = "vertical",
                        listpadding = 10,
                        listhalign = "right",
                        listvalign = "top",
                        children = {
                            one = textlabel:new {
                                size = UDim2.new(0.6,0,0,40),
                                text = "this one is:",
                                textsize = 15,
                            },
                            two = textlabel:new {
                                size = UDim2.new(0.5,0,0,40),
                                text = "vertical!",
                                textsize = 15,
                            },
                            three = textlabel:new {
                                size = UDim2.new(0.9,0,0,40),
                                text = "with top vertical alignment and right horizontal alignment!",
                                textsize = 15,
                            }
                        }
                    }
                }
            }
        }
    }
end