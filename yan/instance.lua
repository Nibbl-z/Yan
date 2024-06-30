local instance = {}

--[[instance.Position = {X = 0, Y = 0}
instance.Rotation = 0
instance.Size = {X = 1, Y = 1}
instance.Sprite = nil]]

function instance:New(o)
    o = o or {
        Name = "",
        Position = {X = 0, Y = 0},
        Rotation = 0,
        Size = {X = 1, Y = 1},
        Sprite = nil
    }
    setmetatable(o, self)
    
    self.__index = self
    return o
end

function instance:SetName(name)
    self.Name = name
end

function instance:SetSprite(spritePath)
    self.Sprite = love.graphics.newImage(spritePath)
end

function instance:Draw()
    if self.Sprite == nil then return end

    love.graphics.draw(
        self.Sprite,
        self.Position.X,
        self.Position.Y,
        self.Rotation,
        self.Size.X,
        self.Size.Y
    )
end

return instance