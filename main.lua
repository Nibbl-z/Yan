local instance = require("yan.instance")

function love.load()
    --[[player = instance:New()
    player:SetSprite("/examples/player.png")

    notPlayer = instance:New()
    notPlayer:SetSprite("/examples/player.png")
    notPlayer.Size.X = 2
    notPlayer.Position.X = 200]]

    object = instance:New()
    object.Name = "bob"
    
    object:SetSprite("/examples/player.png")
    
    object2 = instance:New()
    object2.Name = "gog"

    print(object.Name)
    print(object2.Name)
end

local x = 0

function love.update()
    x = x + 0.1
    
    object.Position.X = math.sin(x) * 100 + 100
end

function love.draw()
    object:Draw()
end