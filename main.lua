local instance = require("yan.instance.instance")
local physicsInstance = require("yan.instance.physics_instance")
local screen = require("yan.instance.ui.screen")
local label = require("yan.instance.ui.label")

function love.load()
    --[[player = instance:New()
    player:SetSprite("/examples/player.png")

    notPlayer = instance:New()
    notPlayer:SetSprite("/examples/player.png")
    notPlayer.Size.X = 2
    notPlayer.Position.X = 200]]
    
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
    myLabel = label:New(myLabel, myScreen, "Hello World", 100, "left")
    myLabel.Size.X = 500
    myLabel:SetPosition(0.5,0,0,0)
    
    myLabel2 = label:New(myLabel2, myScreen, "really long text that should wrap if i did this properly", 16, "left")
    myLabel2:SetPosition(0,50,0,50)
    myLabel2.Size.X = 50
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