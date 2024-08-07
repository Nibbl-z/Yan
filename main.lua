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
local frame = require("yan.instance.ui.frame")
local dropdown = require("yan.instance.ui.dropdown")
local slider = require("yan.instance.ui.slider")
local UIVector2 = require("yan.datatypes.uivector2")
local Vector2 = require("yan.datatypes.vector2")
local Color = require("yan.datatypes.color")
local EasingStyle = require("yan.datatypes.easingstyle")

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    myTheme = themeManager:NewTheme()

    myScreen = screen:New()
    myScreen.Enabled = true
    
    testButton = textButton:New(myScreen, "CLICK FOR SPROINGYNESS!", 16, "center", "center")
    testButton.Position = UIVector2.new(0.5,0,0.5,0)
    testButton.AnchorPoint = Vector2.new(0.5, 0.5)
    testButton.Size = UIVector2.new(0.5,0,0.5,0)
    testButton.CornerRoundness = 0
    testButton.Color = Color.new(1,1,1,1)
    testButton:ApplyTheme(myTheme)

    myTween = tweenManager:NewTween(testButton, tweenManager:NewTweenInfo(1, EasingStyle.ElasticOut), {
        Size = UIVector2.new(0.8,0,0.8,0), 
        Color = Color.new(0.2,1,0.2,1),
        CornerRoundness = 30
    })

    myTween2 = tweenManager:NewTween(testButton, tweenManager:NewTweenInfo(1, EasingStyle.BounceOut), {
        Size = UIVector2.new(0.5,0,0.5,0), 
        Color = Color.new(1,1,1,1),
        CornerRoundness = 30
    })

    testButton.MouseDown = function ()
        myTween:Play()
    end
    
    testImg = image:New(myScreen, "/examples/player.png")
    
    testlbl1 = label:New(myScreen, "slider bar style", 16, "center", "center")
    testlbl2 = label:New(myScreen, "slider fill style", 16, "center", "center")
    testlbl3 = label:New(myScreen, "unsproing the button", 16, "center", "center")

    myDropdown = dropdown:New(myScreen, testImg, {testlbl1, testlbl2, testlbl3})
    myDropdown.Position = UIVector2.new(0, 10, 0, 10)
    myDropdown.Size = UIVector2.new(0.2,0,0.1,0)
    myDropdown:ApplyTheme(myTheme)
    myDropdown.ZIndex = 10
    mySlider = slider:New(myScreen, 0, 100)
    mySlider.Position = UIVector2.new(0, 10, 0.8, 0)
    mySlider.Size = UIVector2.new(0.3,0,0.05,0)
    
    mySlider2 = slider:New(myScreen, 4, 9)
    mySlider2.Position = UIVector2.new(0.8, 10, 0.4, 0)
    mySlider2.Size = UIVector2.new(0.05,0,0.4,0)
    mySlider2.Direction = "vertical"
    
    mySlider2.MouseDown = function ()
        print("hai")
    end

    myDropdown.ItemMouseDown = function (element)
        if element.LayoutOrder == 1 then
            mySlider.Style = "bar"
            mySlider2.Style = "bar"
        elseif element.LayoutOrder == 2 then
            mySlider.Style = "fill"
            mySlider2.Style = "fill"
        elseif element.LayoutOrder == 3 then
            myTween2:Play()
        end
        
    end

    myDropdown.ItemMouseUp = function (element)
        
    end

    awesomeFrame = frame:New(myScreen)
    awesomeFrame.Position = UIVector2.new(0.2, 0, 0.2, 0)
    awesomeFrame.Size = UIVector2.new(0.5, 0, 0.5, 0)
    awesomeFrame.ZIndex = -1
    awesomeFrame.Color = Color.new(1,0,0,0.5)

    testButton:SetParent(awesomeFrame)
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

