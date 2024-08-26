![Yan is a simple instance/UI library for Love2D](https://cloud-ilxgsek0j-hack-club-bot.vercel.app/0yan_thumb.png)

### Features
- Position and scale UI elements relative to the window size
- UI elements can be parented to other UI elements to make their positioning relative to the parent
- Add instances to scenes, which can be enabled and disabled
- Theming system to easily add colors and hovering/click effects to several different UI elements.
- Tweening system to add smooth animations to UI elements and instances.
- Several UI elements, including text labels, buttons, images, lists, grids, scrollables, and text input fields

### How to use
Download the `yan` folder and the `yan.lua` file and put it into the root of your Love2D project. 
Require `yan` at the top of your script. Then you can use any of Yan's features by calling the functions included in `yan.lua`!

```lua
require("yan")
local player = yan:PhysicsInstance(world, "dynamic", "rectangle", {X = 50, Y = 50}, 0, 1)
```

For UI elements, you must first create a screen, which is an instance that holds UI elements.

```lua
myScreen = yan:Screen()
    
text = yan:Label(myScreen, "Hello world!", 32, "center")
text.Position = UIVector2.new(0.5, 0, 0.5, 0)
text.Size = UIVector2.new(1, 0, 0.5, 0)
text.AnchorPoint = Vector2.new(0.5, 0.5)
text.Color = Color.new(0,1,0,1)
text.ZIndex = 1
```

To draw instances, call the `Draw` function on them in `love.draw`. For UI elements, call `yan:Draw()`, which will draw all UI elements across all screens at once.
You'll also need to call some other functions for certain UI elements to function. 

```lua
require("yan")

function love.draw()
    player:Draw()
    yan:Draw()
end

function love.keypressed(key, scancode, rep)
    yan:KeyPressed(key, scancode, rep)
end

function love.textinput(t)
    yan:TextInput(t)
end

function love.wheelmoved(x, y)
    yan:WheelMoved(x, y)
end
```

To add instances to a scene, create a new scene with `yan:NewScene()`, then add the instances to the scene with `yan:AddToScene()`, for example:
```lua
require("yan")

yan:NewScene("User interface")
yan:AddToScene("User interface", {myScreen})
```
Scenes can be enabled or disabled with ```yan:SetSceneEnabled("User interface", true)``` and ```yan:SetSceneEnabled("User interface", false)```

### In Practice

I have used this library myself several times for other Love2D projects to make user interfaces. Here's a list of them:
- Goose Rhythm: [GitHub Page,](https://github.com/Nibbl-z/goose-rhythm) [Itch.io Page](https://nibbl-z.itch.io/goose-rhythm)
- Image Playground: [GitHub Page](https://github.com/Nibbl-z/image-manipulator), [Itch.io Page](https://nibbl-z.itch.io/image-playground)
- Biribiriuo Fishing: [GitHub Page](https://github.com/Nibbl-z/biribiriuo-fishing), [Itch.io Page](https://nibbl-z.itch.io/biribiriuo-fishing)
- Goose Platformer Together: [GitHub Page](https://github.com/Nibbl-z/goose-platformer-multiplayer)
- Space Defenders: [GitHub Page](https://github.com/Nibbl-z/love2d-sock.lua-testing)
