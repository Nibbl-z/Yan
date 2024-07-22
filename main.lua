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

function love.load()
    --[[player = instance:New()
    player:SetSprite("/examples/player.png")
    
    notPlayer = instance:New()
    notPlayer:SetSprite("/examples/player.png")
    notPlayer.Size.X = 2
    notPlayer.Position.X = 200]]
    
    love.window.setMode(800, 600, {resizable = true})

    world = love.physics.newWorld(0, 1000, true)
    
    player = require("examples.player")
    player:Init(world)
    
    ground = physicsInstance:New(ground, world, "static", "rectangle", {X = 30000, Y = 50}, 0, 0)
    ground.body:setY(300)
    ground.Size.X = 30000
    ground.Size.Y = 50
    ground.Shape = "rectangle"
    
    myScreen = screen:New(myScreen)
    myScreen.Enabled = true
    
    text = label:New(nil, myScreen, "My awesome text which is really cool", 32, "center", "center", "/examples/Plumpfull.ttf")
    text:SetPosition(0.5, 0, 0.5, 0)
    text:SetSize(1, 0, 1, 0)
    text:SetAnchorPoint(0.5, 0.5)
    text:SetColor(0,1,0,1)
    text.ZIndex = 5
    
    

    imgButton = imageButton:New(nil, myScreen, "/examples/baloon.jpg")
    imgButton:SetPosition(1,0,0,0)
    imgButton:SetSize(0.2,0,0.2,0)
    imgButton:SetAnchorPoint(1,0,0,0)
    
    imgButton.MouseEnter = function ()
        imgButton:SetColor(0.7,0.7,0.7,1)
    end
    
    imgButton.MouseLeave = function ()
        imgButton:SetColor(1,1,1,1)
    end
    
    imgButton.MouseDown = function ()
        imgButton.Size.XScale = imgButton.Size.XScale + 0.01
        imgButton.Size.YScale = imgButton.Size.YScale + 0.01
    end
    
    imgButton.ZIndex = -2

    img = image:New(nil, myScreen, "/examples/baloon.jpg")
    img:SetPosition(0.5,0,0.5,0)
    img:SetSize(0.3,0,0.3,0)
    img:SetAnchorPoint(0.5,0,0.5,0)
    img:SetColor(1,1,1,1)
    img.ZIndex = -1
    
    
    --[[]]
    
    --[[]]
    
    myList = list:New(nil, myScreen, 10, "left")
    myList:SetPosition(0,10,0,10)
    myList:SetSize(0.3,0,0.7,0)
    myList:SetPadding(0,20,0,20)
    
    parentImage = image:New(nil, myScreen, "/examples/baloon.jpg")
    parentImage:SetSize(1,0,0.4,0)
    parentImage.Name = "Balloon"
    parentImage:SetPadding(0,10,0,10)
    
    button = textButton:New(nil, myScreen, "Click me!!!", 20, "center", "center", "/examples/nulshock bd.otf")
    button:SetPosition(0,0,0,0)
    button:SetSize(1,0,1,0)
    button:SetButtonColor(0.5,0.5,0.5,1)
    button.ZIndex = 3
    
    button.MouseEnter = function ()
        button:SetButtonColor(0.3,0.3,0.3,1)
    end
    
    button.MouseLeave = function ()
        button:SetButtonColor(0.5,0.5,0.5,1)
    end
    
    button.MouseDown = function ()
        print("down")
        button.Text = "welcome back goose"
        button:SetButtonColor(0,1,0,1)
        sceneManager:SetSceneEnabled("awesome scene", true)
        player:GooseAround()
    end

    button.MouseUp = function ()
        print("up")
        button.Text = "Click me to bring the goose back!!!"
        button:SetButtonColor(0.5,0.5,0.5,1)
    end

    button:SetParent(parentImage)

    childImage = image:New(nil, myScreen, "examples/nibblabunga.png")
    childImage:SetSize(1,0,0.2,0)
    childImage.Name = "PlayYan"
    
    descendantImage = image:New(nil, myScreen, "examples/nibblabunga.png")
    descendantImage:SetSize(1,0,0.4,0)
    descendantImage.Name = "Goose"
    
    parentImage:SetParent(myList)
    childImage:SetParent(myList)
    descendantImage:SetParent(myList)
    
    parentImage.LayoutOrder = 1
    childImage.LayoutOrder = 2
    descendantImage.LayoutOrder = 3

    input = textinput:New(nil, myScreen, "Type something here...", 16, "right", "bottom", "/examples/Plumpfull.ttf")
    input:SetColor(0.4,0.4,0.4,1)
    input:SetPosition(1,-10,1,-10)
    input:SetAnchorPoint(1,1)
    input:SetSize(0.4,0,0.2,0)
    
    input.MouseDown = function ()
        input:SetColor(0.2,0.2,0.2,1)
        print("Gup!")
    end

    input.MouseEnter = function ()
        input:SetColor(0.3,0.3,0.3,1)
    end

    input.MouseLeave = function ()
        input:SetColor(0.4,0.4,0.4,1)
    end

    input.OnEnter = function ()
        print(input.Text)
        sceneManager:SetSceneEnabled("awesome scene", false)
    end
    
    sceneManager:NewScene("awesome scene")
    sceneManager:AddToScene("awesome scene", {
        player.instance,
        ground
    })
    
    sceneManager:NewScene("User interface??")
    sceneManager:AddToScene("User interface??", {myScreen})
end

function love.update(dt)
    player:Update(dt)
    ground:Update()
    world:update(dt)

    uiManager:Update()
end

function love.keypressed(key, scancode, rep)
    uiManager:KeyPressed(key, scancode, rep)
end

function love.textinput(t)
    uiManager:TextInput(t)
end

function love.draw()
    love.graphics.setBackgroundColor(0.5,0.5,0.5,1)
    player.instance:Draw()
    ground:Draw()
    uiManager:Draw()
end