local registry = {}
registry.screens = {}
registry.updatefuncs = {}
registry.tweens = {}

function registry:addscreen(screen)
    table.insert(registry.screens, screen)
end

function registry:addupdatefunc(element, property, func)
    table.insert(registry.updatefuncs, {element = element, property = property, func = func})
end

function registry:addtween(tween)
    table.insert(registry.tweens, tween)
end

function registry:draw()
    table.sort(self.screens, function (a, b)
        return a.layoutorder < b.layoutorder
    end)
    
    for _, screen in ipairs(self.screens) do
        screen:draw()
    end
end

function registry:update(dt)
    for _, screen in ipairs(self.screens) do
        screen:update()
    end

    for _, func in ipairs(self.updatefuncs) do
        func.element[func.property] = func.func(func.element, dt)
    end

    for _, tween in ipairs(self.tweens) do
        tween:_update(dt)
    end
end

function registry:textinput(text)
    for _, screen in ipairs(self.screens) do
        screen:textinput(text)
    end
end

function registry:keypressed(key)
    for _, screen in ipairs(self.screens) do
        screen:keypressed(key)
    end
end

return registry