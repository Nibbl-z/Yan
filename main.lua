local instance = require("yan.instance.instance")
local physicsInstance = require("yan.instance.physics_instance")

function love.load()
    --[[player = instance:New()
    player:SetSprite("/examples/player.png")

    notPlayer = instance:New()
    notPlayer:SetSprite("/examples/player.png")
    notPlayer.Size.X = 2
    notPlayer.Position.X = 200]]
    
    world = love.physics.newWorld(0, 1000, true)
    
    object = physicsInstance:New(object, world, "dynamic", "rectangle", {X = 50, Y = 50}, 0)
    object.body:setX(200)

    object:SetSprite("/examples/player.png")
    
    ground = physicsInstance:New(ground, world, "static", "rectangle", {X = 500, Y = 50}, 0)
    ground.body:setY(300)
end

local x = 0

function love.update(dt)
    object:Update()
    world:update(dt)
end

function love.draw()
    object:Draw()
end