local instance = require("yan.instance.instance")
local physicsInstance = require("yan.instance.physics_instance")
local screen = require("yan.instance.ui.screen")
local label = require("yan.instance.ui.label")
local guiBase = require("yan.instance.ui.guibase")

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
    
    element = guiBase:New(element, myScreen)
    element:SetPosition(0, 20, 0, 20)
    element:SetSize(1, -40, 1, -40)
    
    text = label:New(nil, myScreen, "My awesome text which is really cool", 64, "center")
    text:SetPosition(0.5, 0, 0, 0)
    text:SetSize(0.5, 0, 0.5, 0)
    text:SetAnchorPoint(0.5, 0.5)
    text:SetColor(0,1,0,1)
    text.ZIndex = 1
    
    text2 = label:New(nil, myScreen, "THIS TEXT IS BETTER", 100, "center")
    text2:SetPosition(0.5, 0, 0, 0)
    text2:SetSize(0.5, 0, 0.5, 0)
    text2:SetAnchorPoint(0.5, 0.5)
    text2:SetColor(1,0,0,1)
    text2.ZIndex = 2

    text3 = label:New(nil, myScreen, "THIS TEXT IS EVEN BETTER", 150, "center")
    text3:SetPosition(0, 0, 0, 0)
    text3:SetSize(1, 0, 1, 0)
    text3:SetAnchorPoint(0,0)
    text3:SetColor(0,0,1,1)
    text3.ZIndex = 3
end

local x = 0

function love.update(dt)
    player:Update(dt)
    ground:Update()
    world:update(dt)
end

function love.draw()
    player.instance:Draw()
    ground:Draw()
    myScreen:Draw()
end