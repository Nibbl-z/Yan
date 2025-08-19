# Yan
Yan is a simple UI library for Love2D, based on Roblox's UI system

### Demo

<video src="https://summer.hackclub.com/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NTQzODcsInB1ciI6ImJsb2JfaWQifX0=--e72437be3fabd10af77a7fb7cf9b860ca0fc7b98/2025-08-18%2016-09-32.mp4" width="320" height="240" controls></video>

### Features
- Position and scale UI elements relative to the window size
- UI elements can be parented to other UI elements to make their positioning relative to the parent
- Several UI elements, including text labels, buttons, images, and text input fields
- Fully documented with LDoc

### How to use
Download the `yan` folder and `yan.lua` file and put it into your Love2D project.


```lua
-- Add this to the top of your lua file.

require "yan"

function love.load()
    -- All UI elements need to be added to a screen
    myScreen = screen:new()

    element = uibase:new()
    -- Position/scale elements with UDim2s
    element.position = UDim.new(0.5, 0, 0.5, 0)
    -- Color elements with Colors (wow!)
    element.backgroundcolor = Color.new(0.5,1,0.7,0.5)

    -- Add elements to screens with screen:addelement
    myScreen:addelement(element)

    -- You can add multiple elements to a screen at once with screen:addelements
    myScreen:addelements({element1, element2, element3})
end

-- Call :draw on all screens in love.draw
function love.draw()
    mainScreen:draw()
end

-- Call :update on all screens in love.update
function love.update()
    mainScreen:update()
end

-- Call :textinput on all screens in love.textinput
function love.textinput(text)
    mainScreen:textinput(text)
end

-- Call :keypressed on all screens in love.keypressed
function love.keypressed(key)
    mainScreen:keypressed(key)
end
```
