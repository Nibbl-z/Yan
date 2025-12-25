--- Contains UI elements and handles the updating and rendering of them all
---@class Screen
---@field elements UIBase[] A table of all elements in the Screen
---@field enabled boolean If enabled, the screen will render. This does not stop elements from updating
---@field layoutorder boolean The order that the screens will render compared to other screens
screen = {}
screen.__index = screen

local registry = require "yan.registry"

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

    for k, v in pairs(elements) do
        v.name = k
        table.insert(object.elements, v)
    end

    registry:addscreen(object)

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

    local function drawElements(elements)
        table.sort(elements, function (a, b)
            return a.zindex + a._creationorder < b.zindex + b._creationorder
        end)

        for _, element in ipairs(elements) do
            if element:isvisible() then
                element:stencil(element.parent)
                element:draw()
                love.graphics.setStencilTest()
            end
            if #element.children > 0 then
                drawElements(element.children)
            end
        end
    end

    drawElements(self.elements)
end

--- Updates all elements in the screen
function screen:update()
    if not self.enabled then return end

    local function updateElements(elements)
        for _, element in ipairs(elements) do
            element:update()
            if #element.children > 0 then
                updateElements(element.children)
            end
        end
    end

    updateElements(self.elements)
end

--- Calls `love.textinput` on all elements that need it
function screen:textinput(text)
    if not self.enabled then return end

    local function updateElements(elements)
        for _, element in ipairs(elements) do
            if element._type == "TextInput" then
                ---@diagnostic disable-next-line: undefined-field
                element:textinput(text)
            end
            if #element.children > 0 then
                updateElements(element.children)
            end
        end
    end

    updateElements(self.elements)
end

--- Calls `love.keypressed` on all elements that need it
function screen:keypressed(key)
    if not self.enabled then return end

    local function updateElements(elements)
        for _, element in ipairs(elements) do
            if element._type == "TextInput" then
                ---@diagnostic disable-next-line: undefined-field
                element:keypressed(key)
            end
            if #element.children > 0 then
                updateElements(element.children)
            end
        end
    end

    updateElements(self.elements)
end

return screen