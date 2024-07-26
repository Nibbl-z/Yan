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
local themeManager = require("yan.thememanager")
local scrollable = require("yan.instance.ui.scrollable")
local grid = require("yan.instance.ui.grid")

function love.load()

    love.window.setMode(800, 600, {resizable = true})
    myTheme = themeManager:NewTheme()
    myTheme.Font = "/examples/Plumpfull.ttf"
    myTheme:SetColor(0.4, 1, 0.4, 1)
    myTheme:SetHoverColor(0.3, 0.8, 0.3, 1)
    myTheme:SetSelectedColor(0.2, 0.7, 0.2, 1)
    myTheme:SetTextColor(1,1,1,1)
    myTheme.CornerRoundness = 10

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
    text:SetTextColor(0,1,0,1)
    text.ZIndex = 5
    text:ApplyTheme(myTheme)    
    
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
    
    scroll = scrollable:New(nil, myScreen, "horizontal")
    scroll:SetPosition(0,10,0,10)
    scroll:SetSize(0.3,0,0.6,0)
    scroll:SetPadding(0,20,0,20)
    scroll.MaskChildren = true
    scroll.ZIndex = -1
    
    scroll2 = scrollable:New(nil, myScreen, "horizontal")
    scroll2:SetPosition(0.3,20,0,10)
    scroll2:SetSize(0.7,0,0.7,0)
    scroll2:SetPadding(0,20,0,20)
    scroll2.MaskChildren = true
    scroll2.ZIndex = -2
    
    mygrid = grid:New(nil, myScreen, 10, "bottom", "right", "vertical", 4)
    mygrid:SetPosition(0,0,0,0)
    mygrid:SetSize(1,0,1,0)
    --myList:SetPadding(0,20,0,20)
    mygrid.MaskChildren = false
    mygrid.ZIndex = -1
    mygrid:ApplyTheme(myTheme)
    mygrid:SetParent(scroll2)

    parentImage = image:New(nil, myScreen, "/examples/baloon.jpg")
    parentImage:SetSize(1,0,1,0)
    parentImage.Name = "Balloon"
    parentImage:SetPadding(0,10,0,10)
    
    button = textButton:New(nil, myScreen, "Click this themed button!!! yay!!!", 20, "center", "center", "/examples/nulshock bd.otf")
    button:SetPosition(0.75,0,0.75,0)
    button:SetSize(0.2, 0, 0.2, 0)
    
    
    button:ApplyTheme(myTheme)
    
    button.ZIndex = 3
    
    
    img.MaskChildren = true
    
    childImage = image:New(nil, myScreen, "examples/nibblabunga.png")
    childImage:SetSize(0,100,0,100)
    childImage.Name = "PlayYan"
    
    descendantImage = image:New(nil, myScreen, "examples/player.png")
    descendantImage:SetSize(0,100,0,100)
    descendantImage.Name = "Goose"
    descendantImage.ZIndex = 4

    descendantImage2 = image:New(nil, myScreen, "examples/baloon.jpg")
    descendantImage2:SetSize(0,100,0,100)
    descendantImage2.Name = "Goose2"

    descendantImage3 = image:New(nil, myScreen, "examples/player.png")
    descendantImage3:SetSize(0,100,0,100)
    descendantImage3.Name = "Goose3"
    descendantImage3.ZIndex = 4

    descendantImage4 = image:New(nil, myScreen, "examples/nibblabunga.png")
    descendantImage4:SetSize(0,100,0,100)
    descendantImage4.Name = "Goose4"
    
    parentImage:SetParent(scroll)
    childImage:SetParent(mygrid)
    descendantImage:SetParent(mygrid)
    descendantImage2:SetParent(mygrid)
    descendantImage3:SetParent(mygrid)
    descendantImage4:SetParent(mygrid)
    
    parentImage.LayoutOrder = 1
    childImage.LayoutOrder = 1
    descendantImage.LayoutOrder = 2
    descendantImage2.LayoutOrder = 3
    descendantImage3.LayoutOrder = 4
    descendantImage4.LayoutOrder = 5

    input = textinput:New(nil, myScreen, "Type something here...", 16, "right", "bottom", "/examples/Plumpfull.ttf")
    input:SetPosition(1,-10,1,-10)
    input:SetAnchorPoint(1,1)
    input:SetSize(0.2,0,0.2,0)
    input.ZIndex = 1
    input:ApplyTheme(myTheme)
    
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

function love.wheelmoved(x, y)
    uiManager:WheelMoved(x, y)
end

function love.draw()
    love.graphics.setBackgroundColor(0.5,0.5,0.5,1)
    player.instance:Draw()
    ground:Draw()
    uiManager:Draw()
end

