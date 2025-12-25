# Yan
Yan is a simple UI library for Love2D, based on Roblox's UI system and inspired by [Fusion.](https://github.com/dphfox/Fusion)

### Demo

(todo)

You can view the code to the examples in the demo video in /examples and main.lua to further understand how to use Yan!

### Features
- Short and simple syntax for instantiating UI elements and their children
- Position and scale UI elements relative to the window size
- UI elements can be parented to other UI elements to make their positioning relative to the parent
- Screen system to handle several different interfaces at once
- Several UI elements, including text labels, images, and text input fields
- Mouse enter, exit, and click events on elements
- Padding option on elements
- List layouts, with horizontal/vertical alignment, direction, and padding
- Basic style options, such as fonts, corner roundness, and outlines
- Tweening system provided with all common easing types for smooth UI animations
- Make element properties automatically update by setting them to a function that returns a value instead of a static value
- Fully documented

### How to use
Download the `yan` folder and `yan.lua` file and put it into your Love2D project.

```lua
-- Add this to the top of your lua file.

require "yan"

function love.load()
    local clicks = 0

    -- All UI elements need to be added to a screen
    myScreen = screen:new {
        -- Key of element is its name
        elementName = uibase:new {
            -- Position and scale elements with UDim2s
            size = UDim2.new(0.5, 10, 0.5, 10), 
            -- Color elements with Colors (wow!)
            backgroundcolor = Color.new(1,0.5,1,1), 
            -- Add child elements with the children property
            children = { 
                label = textlabel:new {
                    -- Update properties in love.update automatically when setting values to functions
                    text = function() 
                        return "Hello world! I've been clicked " .. tostring(clicks) .. " times!"
                    end,
                    -- Event properties can run functions
                    mousebutton1up = function() 
                        clicks = clicks + 1
                    end
                }
            }
        }
    }

    -- Access elements later with :get()

    local element = myScreen:get("elementName")
    element.position = UDim2.new(0.2, 0, 0.2, 0)
end

-- Add the following yan functions into these love functions
function love.draw()
    yan:draw()
end

function love.update(dt)
    yan:update(dt)
end

function love.textinput(text)
    yan:textinput(text)
end

function love.keypressed(key)
    yan:keypressed(key)
end
```