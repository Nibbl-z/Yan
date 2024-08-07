# Yan
Yan is a simple instance/UI library for Love2D

### Features
- Position and scale UI elements relative to the window size
- UI elements can be parented to other UI elements to make their positioning relative to the parent
- Add instances to scenes, which can be enabled and disabled
- Theming system to easily add colors and hovering/click effects to several different UI elements.
- Tweening system to add smooth animations to UI elements and instances.
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
local player = physicsInstance:New(world, "dynamic", "rectangle", {X = 50, Y = 50}, 0, 1)
```

For UI elements, you must first create a screen, which is an instance that holds UI elements.

```lua
local UIVector2 = require("yan.datatypes.uivector2")
local Vector2 = require("yan.datatype.vector2")
local Color = require("yan.datatype.color")
myScreen = screen:New()
myScreen.Enabled = true
    
text = label:New(myScreen, "Hello world!", 32, "center")
text.Position = UIVector2.new(0.5, 0, 0.5, 0)
text.Size = UIVector2.new(1, 0, 0.5, 0)
text.AnchorPoint = Vector2.new(0.5, 0.5)
text.Color = Color.new(0,1,0,1)
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
