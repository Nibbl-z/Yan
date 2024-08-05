local instance = {}
instance.__index = instance
--[[instance.Position = {X = 0, Y = 0}
instance.Rotation = 0
instance.Size = {X = 1, Y = 1}
instance.Sprite = nil]]

local Vector2 = require("yan.datatypes.vector2")
local Color = require("yan.datatypes.color")

function instance:New(o, name)
    o = o or {
        Name = name,
        Position = Vector2.new(0,0),
        Rotation = 0,
        Size = Vector2.new(1,1),
        Offset = Vector2.new(0,0),
        Sprite = nil,
        Shape = nil,
        Color = Color.new(1,1,1,1),
        Type = "Instance",
        Scene = nil,
        SceneEnabled = true
    }
    setmetatable(o, self)
    
    if name == nil then
        math.randomseed(love.timer.getTime())
        o.Name = tostring(love.timer.getTime() * 1000 * math.random(1,1000))
    end

    return o
end

function instance:SetName(name)
    self.Name = name
end

function instance:SetSprite(spritePath)
    self.Sprite = love.graphics.newImage(spritePath)
end

function instance:Draw()
    if self.SceneEnabled == false then return end
    love.graphics.setColor(
        self.Color.R,
        self.Color.G,
        self.Color.B,
        self.Color.A
    )

    if self.Sprite ~= nil then
        love.graphics.draw(
            self.Sprite,
            self.Position.X,
            self.Position.Y,
            self.Rotation,
            self.Size.X,
            self.Size.Y,
            self.Offset.X,
            self.Offset.Y
        )
    elseif self.Shape == "rectangle" then
        love.graphics.rectangle(
            "fill",
            self.Position.X,
            self.Position.Y,
            self.Size.X,
            self.Size.Y
        )
    end
end

return instance