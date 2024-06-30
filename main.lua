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
    
    player = require("examples.player")
    player:Init(world)
    
    ground = physicsInstance:New(ground, world, "static", "rectangle", {X = 30000, Y = 50}, 0, 0)
    ground.body:setY(300)
end

local x = 0

function love.update(dt)
    player:Update(dt)
    world:update(dt)
end

function love.draw()
    player.instance:Draw()
end