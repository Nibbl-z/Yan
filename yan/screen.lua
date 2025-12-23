--- Contains UI elements and handles the updating and rendering of them all
---@class Screen
---@field elements UIBase[] A table of all elements in the Screen
---@field enabled boolean Should the screen render?
---@field layoutorder boolean The order that the screens will render compared to other screens
screen = {}
screen.__index = screen

local manager = require "yan.manager"

--- Creates a new Screen with elements
---@param elements UIBase[]
---@return Screen screen
function screen:new(elements)
    local object = {
        elements = {},
        enabled = true,
        layoutorder = 0
    }
    
    
    setmetatable(object, self)

    function addChildrenElements(elements, previousIndex)
        for name, element in pairs(elements) do
            object:addelement(element)
            element._ancestorCount = previousIndex + 1
            addChildrenElements(element.children, previousIndex + 1)
        end
    end

    for k, v in pairs(elements) do
        v.name = k
        table.insert(object.elements, v)
    end

    for k, v in pairs(object.elements) do
        addChildrenElements(v.children, 0)
    end

    manager:addscreen(object)

    return object
end

--- Finds the first child element with the name provided
---@param name string Name of element to find
---@return UIBase|TextLabel|TextInput|ImageLabel|nil element Element if found, nil if not
function screen:get(name)
    for _, element in pairs(self.elements) do
        if element.name == name then
            return element
        end
    end

    return nil
end

--- Adds an element to a screen
---@param element UIBase
function screen:addelement(element)
    table.insert(self.elements, element)
end

--- Adds multiple elements at once to a screen
---@param elements UIBase[]
function screen:addelements(elements)
    for _, element in pairs(elements) do
        table.insert(self.elements, element)
    end
end

--- Draws all elements in the screen
function screen:draw()
    if not self.enabled then return end

    table.sort(self.elements, function (a, b)
        return a.zindex + a._creationorder < b.zindex + b._creationorder
    end)

    table.sort(self.elements, function (a, b)
        return a._ancestorCount < b._ancestorCount
    end)
    
    for _, element in ipairs(self.elements) do
        if element.visible then
            element:stencil(element.parent)
            element:draw()
            love.graphics.setStencilTest()
        end
    end
end

--- Updates all elements in the screen
function screen:update()
    if not self.enabled then return end

    for _, element in ipairs(self.elements) do
        element:update()
    end
end

--- Calls `love.textinput` on all elements that need it
function screen:textinput(text)
    if not self.enabled then return end

    for _, element in ipairs(self.elements) do
        if element._type == "TextInput" then
            ---@diagnostic disable-next-line: undefined-field
            element:textinput(text)
        end
    end
end

--- Calls `love.keypressed` on all elements that need it
function screen:keypressed(key)
    if not self.enabled then return end

    for _, element in ipairs(self.elements) do
        if element._type == "TextInput" then
            ---@diagnostic disable-next-line: undefined-field
            element:keypressed(key)
        end
    end
end

return screen