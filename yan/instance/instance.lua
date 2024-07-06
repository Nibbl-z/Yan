local instance = {}
instance.__index = instance
--[[instance.Position = {X = 0, Y = 0}
instance.Rotation = 0
instance.Size = {X = 1, Y = 1}
instance.Sprite = nil]]

function instance:New(o, name)
    o = o or {
        Name = name,
        Position = {X = 0, Y = 0},
        Rotation = 0,
        Size = {X = 1, Y = 1},
        Offset = {X = 0, Y = 0},
        Sprite = nil,
        Shape = nil,
        Color = {R = 1, G = 1, B = 1, A = 1},
        Type = "Instance",
        Scene = nil,
        SceneEnabled = true
    }
    setmetatable(o, self)

    if name == nil then
        math.randomseed(love.timer.getTime())
        o.Name = tostring(love.timer.getTime() * 1000 * math.random(1,1000))
    end
    
    function o:SetColor(r, g, b, a)
        o.Color = {
            R = r, G = g, B = b, A = a
        }
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