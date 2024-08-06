local instance = require("yan.instance.instance")
local physicsInstance = require("yan.instance.physics_instance")
local screen = require("yan.instance.ui.screen")
local label = require("yan.instance.ui.label")
local guiBase = require("yan.instance.ui.guibase")
local textButton = require("yan.instance.ui.textbutton")
local imageButton = require("yan.instance.ui.imagebutton")
local image = require("yan.instance.ui.image")
local list = require("yan.instance.ui.list")
local textinput = require("yan.instance.ui.textinput")
local sceneManager = require("yan.scenemanager")
local uiManager = require("yan.uimanager")
local tweenManager = require("yan.tweenmanager")
local themeManager = require("yan.thememanager")
local scrollable = require("yan.instance.ui.scrollable")
local grid = require("yan.instance.ui.grid")

local UIVector2 = require("yan.datatypes.uivector2")
local Vector2 = require("yan.datatypes.vector2")
local Color = require("yan.datatypes.color")
local EasingStyle = require("yan.datatypes.easingstyle")

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    myScreen = screen:New(nil)
    myScreen.Enabled = true
    
    testButton = textButton:New(nil, myScreen, "HAI!", 32, "center", "center")
    testButton.Position = UIVector2.new(0.5,0,0.2,0)
    testButton.AnchorPoint = Vector2.new(0.5, 0.5)
    testButton.Size = UIVector2.new(0.3,0,0.3,0)
    testButton.CornerRoundness = 0
    testButton.Color = Color.new(1,1,1,1)
    
    myTween = tweenManager:NewTween(testButton, tweenManager:NewTweenInfo(2, EasingStyle.BounceOut), {
        Position = UIVector2.new(0.5,0,0.8,0), 
        CornerRoundness = 32,
        Color = Color.new(0,1,0,1)
    })
    
    testButton.MouseDown = function ()
        myTween:Play()
    end
end

function love.update(dt)
    uiManager:Update()
    tweenManager:Update(dt)
end

function love.keypressed(key, scancode, rep)

end

function love.textinput(t)

end

function love.wheelmoved(x, y)

end

function love.draw()
    love.graphics.setBackgroundColor(0.5,0.5,0.5,1)
    uiManager:Draw()
end

