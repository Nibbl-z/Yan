local physicsInstance = {}
local instance = require("yan.instance.instance")
physicsInstance.__index = instance

function physicsInstance:New(o, world, bodyType, shape, size, restitution)
    o = o or instance:New(o)
    setmetatable(o, self)
   
    o.body = love.physics.newBody(world, o.Position.X, o.Position.Y, bodyType)
    
    if shape == "rectangle" then
        o.shape = love.physics.newRectangleShape(size.X, size.Y)
    end
    
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setUserData(o.Name)
    o.fixture:setRestitution(restitution)
    
    function o:Update()
        self.Position.X = self.body:getX()
        self.Position.Y = self.body:getY()
    end 

    function o:ApplyForce(x, y)
        self.body:applyForce(x, y)
    end
    
    return o
end

return physicsInstance