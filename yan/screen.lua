--- Contains UI elements and handles the updating and rendering of them all
---@class Screen
---@field elements UIBase[] A table of all elements in the Screen
---@field enabled boolean Should the screen render?
---@field layoutorder boolean The order that the screens will render compared to other screens
screen = {}
screen.__index = screen

--- Creates a new Screen
function screen:new()
    local object = {
        elements = {},
        enabled = true,
        layoutorder = 0
    }

    setmetatable(object, self)
    return object
end

--- Adds an element to a screen
---@param element UIBase
function screen:addelement(element)
    table.insert(self.elements, element)
end

--- Adds multiple elements at once to a screen
---@param elements UIBase[]
function screen:addelements(elements)
    for _, element in ipairs(elements) do
        table.insert(self.elements, element)
    end
end

-- Draws all elements in the screen
function screen:draw()
    if not self.enabled then return end

    table.sort(self.elements, function (a, b)
        return a.zindex + a._creationorder < b.zindex + b._creationorder
    end)
    
    for _, element in ipairs(self.elements) do
        element:stencil(element.parent)
        element:draw()
        love.graphics.setStencilTest()
    end
end

-- Updates all elements in the screen
function screen:update()
    for _, element in ipairs(self.elements) do
        element:update()
    end
end

return screen