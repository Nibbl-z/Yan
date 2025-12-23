local manager = {}
manager.screens = {}
manager.updatefuncs = {}

function manager:addscreen(screen)
    table.insert(manager.screens, screen)
end

function manager:addupdatefunc(element, property, func)
    table.insert(manager.updatefuncs, {element = element, property = property, func = func})
end

function manager:draw()
    table.sort(self.screens, function (a, b)
        return a.layoutorder < b.layoutorder
    end)
    
    for _, screen in ipairs(self.screens) do
        screen:draw()
    end
end

function manager:update()
    for _, screen in ipairs(self.screens) do
        screen:update()
    end

    for _, func in ipairs(self.updatefuncs) do
        func.element[func.property] = func.func()
    end
end

function manager:textinput(text)
    for _, screen in ipairs(self.screens) do
        screen:textinput(text)
    end
end

function manager:keypressed(key)
    for _, screen in ipairs(self.screens) do
        screen:keypressed(key)
    end
end

return manager