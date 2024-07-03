local player = {}
local physicsInstance = require("yan.instance.physics_instance")


function player:Init(world)
    self.instance = physicsInstance:New(self.instance, world, "dynamic", "rectangle", {X = 50, Y = 50}, 0, 1)
    self.instance:SetSprite("/examples/player.png")
    self.instance.Offset.X = 25
end

function player:Update(dt)
    self.instance:Update()
    
    if love.keyboard.isDown("a") then
        print("a")
        self.instance.Size.X = 1
        self.instance:ApplyLinearImpulse(-7000 * dt, 0)
    end

    if love.keyboard.isDown("d") then
        print("d")
        self.instance.Size.X = -1
        self.instance:ApplyLinearImpulse(7000 * dt, 0)
    end
end

function player:GooseAround()
    self.instance.Size.Y = self.instance.Size.Y * 1.1
end

return player