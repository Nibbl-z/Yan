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
local dropdown = require("yan.instance.ui.dropdown")
local slider = require("yan.instance.ui.slider")
local UIVector2 = require("yan.datatypes.uivector2")
local Vector2 = require("yan.datatypes.vector2")
local Color = require("yan.datatypes.color")
local EasingStyle = require("yan.datatypes.easingstyle")

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    myTheme = themeManager:NewTheme()

    myScreen = screen:New(nil)
    myScreen.Enabled = true
    
    testButton = textButton:New(nil, myScreen, "HAI!", 32, "left", "top")
    testButton.Position = UIVector2.new(0.5,0,0.5,0)
    testButton.AnchorPoint = Vector2.new(0.5, 0.5)
    testButton.Size = UIVector2.new(0.3,0,0.3,0)
    testButton.CornerRoundness = 0
    testButton.Color = Color.new(1,1,1,1)
    testButton:ApplyTheme(myTheme)
    myTween = tweenManager:NewTween(testButton, tweenManager:NewTweenInfo(1, EasingStyle.ElasticOut), {
        Size = UIVector2.new(0.5,0,0.3,0), 
        CornerRoundness = 30
    })

    myTween2 = tweenManager:NewTween(testButton, tweenManager:NewTweenInfo(1, EasingStyle.BounceOut), {
        Size = UIVector2.new(0.2,0,0.8,0), 
        CornerRoundness = 30
    })
    
    testImg = image:New(nil, myScreen, "/examples/player.png")
    
    testImg2 = image:New(nil, myScreen, "/examples/nibblabunga.png")
    testImg3 = image:New(nil, myScreen, "/examples/baloon.jpg")

    myDropdown = dropdown:New(myScreen, testImg, {testImg2, testImg3})
    myDropdown.Position = UIVector2.new(0, 10, 0, 10)
    myDropdown.Size = UIVector2.new(0.2,0,0.1,0)
    myDropdown:ApplyTheme(myTheme)
    myDropdown.ZIndex = 10

    myDropdown.ItemClicked = function (element)
        if element.LayoutOrder == 1 then
            myTween:Play()
        else
            myTween2:Play()
        end
        print(element.LayoutOrder)
    end

    mySlider = slider:New(myScreen, 0, 100)
    mySlider.Position = UIVector2.new(0, 10, 0.8, 0)
    mySlider.Size = UIVector2.new(0.4,0,0.1,0)
end

function love.update(dt)
    uiManager:Update()
    tweenManager:Update(dt)
end

function love.keypressed(key, scancode, rep)
    uiManager:KeyPressed(key, scancode, rep)
end

function love.textinput(t)
    uiManager:TextInput(t)
end

function love.wheelmoved(x, y)
    uiManager:WheelMoved(x,y)
end

function love.draw()
    love.graphics.setBackgroundColor(0.3,0.3,0.3,1)
    uiManager:Draw()
end

