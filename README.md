# Yan
Yan is a simple instance/UI library for Love2D

### Features
- Position and scale UI elements relative to the window size
- UI elements can be parented to other UI elements to make their positioning relative to the parent
- Add instances to scenes, which can be enabled and disabled
- Theming system to easily add colors and hovering/click effects to several different UI elements.
- Several UI elements, including text labels, buttons, images, lists, grids, scrollables, and text input fields

### How to use
Download the `yan` folder and put it into your Love2D project. 
Instances can be created by requiring their script, for example:
```lua
local instance = require("yan.instance.instance")
local label = require("yan.instance.ui.label")
```
Create a new instance by calling the `New` function on any instance, for example:
```lua
local player = physicsInstance:New(nil, world, "dynamic", "rectangle", {X = 50, Y = 50}, 0, 1)
```

For UI elements, you must first create a screen, which is an instance that holds UI elements.

```lua
myScreen = screen:New(myScreen)
myScreen.Enabled = true
    
text = label:New(nil, myScreen, "Hello world!", 32, "center")
text:SetPosition(0.5, 0, 0.5, 0)
text:SetSize(1, 0, 0, 0)
text:SetAnchorPoint(0.5, 0.5)
text:SetColor(0,1,0,1)
text.ZIndex = 1
```

To draw instances, call the `Draw` function on them in `love.draw`. For UI elements, call `Draw` on the `UIManager` module, which will draw all UI elements across all screens at once.
With the `UIManager` module, you'll also need to call some other functions for certain UI elements to function. 

```lua
local uiManager = require("yan.uimanager")

function love.keypressed(key, scancode, rep)
    uiManager:KeyPressed(key, scancode, rep)
end

function love.textinput(t)
    uiManager:TextInput(t)
end

function love.wheelmoved(x, y)
    uiManager:WheelMoved(x, y)
end
```

To add instances to a scene, create a new scene with `SceneManager:NewScene()`, then add the instances to the scene with `SceneManager:AddToScene()`, for example:
```lua
local SceneManager = require("yan.scenemanager")
SceneManager:NewScene("User interface")
SceneManager:AddToScene("User interface", {myScreen})
```
Scenes can be enabled or disabled with ```SceneManager:SetSceneEnabled("User interface", true)``` and ```SceneManager:SetSceneEnabled("User interface", false)```
