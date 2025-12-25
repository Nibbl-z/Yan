require "yan.datatypes.udim2"
require "yan.datatypes.udim"
require "yan.datatypes.vector2"
require "yan.datatypes.color"

local common = require "yan.common"
local registry = require "yan.registry"

--- The base of all interface elements that other elements inherit from
---@class UIBase
---@field _type? string The type of interface element
---@field name? string The name of the element, to be used in `screen:get()`
---@field visible? boolean If true, the element and its children will be rendered. If false, the element and its children will not render, and also disables all events from running on the element, but not updating functions
---@field position? UDim2 Position of the element
---@field size? UDim2 Size of the element
---@field anchorpoint? Vector2 The origin point where the element will be positioned and scaled from
---@field backgroundcolor? Color Background color of the element
---@field clipdescendants? boolean Should the children of this element be masked?
---@field cornerradius? UDim Radius of rounded corners
---@field bordersize? number Size of border
---@field bordercolor? Color Color of border
---@field leftpadding? UDim The amount of padding on children elements on the left side
---@field toppadding? UDim The amount of padding on children elements on the top side
---@field rightpadding? UDim The amount of padding on children elements on the right side
---@field bottompadding? UDim The amount of padding on children elements on the bottom side
---@field layout? "default"|"list" The way that child elements are positioned
---@field listpadding? number The amount of pixels of padding between elements when `layout` is set to `list`
---@field listdirection? "vertical"|"horizontal" The direction that elements will be placed when `layout` is set to `list`
---@field listhalign? "left"|"center"|"right" The horizontal alignment of elements when `layout` is set to `list`
---@field listvalign? "top"|"center"|"bottom" The vertical alignment of elements when `layout` is set to `list`
---@field zindex? number The order that the element is drawn in based on every other element in the Screen
---@field layoutorder? number The order that the element is drawn when the parent has `layout` set to `list`
---@field children? table A table of children that this element contains
---@field parent? UIBase The element that this element is parented to, `nil` if element has no parent
---@field mouseenter? fun(self, x: number, y: number) Function that runs when the mouse enters the element
---@field mouseexit? fun(self, x: number, y: number) Function that runs when the mouse exits the element
---@field mousebutton1down? fun(self) Function that runs when the primary mouse button is clicked within the element
---@field mousebutton1up? fun(self) Function that runs when the primary mouse button is released within the element
---@field mousebutton2down? fun(self) Function that runs when the secondary mouse button is clicked within the element
---@field mousebutton2up? fun(self) Function that runs when the secondary mouse button is released within the element
---@field _hovered? boolean
---@field _button1clicked? boolean
---@field _button2clicked? boolean
---@field _creationorder? number
uibase = {}
uibase.__index = uibase

local creationIndex = 0

--- Creates a new UIBase
---@param props UIBase
function uibase:new(props)
    local object = {
        _type = "UIBase",
        name = "Unnamed",
        visible = true,
        position = UDim2.new(0, 0, 0, 0),
        size = UDim2.new(0, 100, 0, 100),
        anchorpoint = Vector2.new(0, 0),
        backgroundcolor = Color.new(1,1,1,1),
        
        clipdescendants = false,
        zindex = 0,
        layoutorder = 0,
        children = {},
        parent = nil,
        layout = "default",
        listpadding = 0,
        listdirection = "vertical",
        listhalign = "left",
        listvalign = "top",

        cornerradius = UDim.new(0, 0),
        bordersize = 0,
        bordercolor = Color.new(0,0,0,1),

        leftpadding = UDim.new(0, 0),
        toppadding = UDim.new(0, 0),
        rightpadding = UDim.new(0, 0),
        bottompadding = UDim.new(0, 0),
        
        mouseenter = function () end,
        mouseexit = function () end,
        mousebutton1down = function () end,
        mousebutton1up = function () end,
        mousebutton2down = function () end,
        mousebutton2up = function () end,

        _hovered = false,
        _button1clicked = false,
        _button2clicked = false,
        _creationorder = creationIndex,
    }

    for k, v in pairs(props) do
        if k == "children" then
            for name, element in pairs(v) do
                element.name = name
                element:setparent(object)
            end
        else
            if type(v) == "function" and type(object[k]) ~= "function" then
                registry:addupdatefunc(object, k, v)
                object[k] = v(object, 1/60)
            else
                object[k] = v
            end
        end
    end
    
    creationIndex = creationIndex + 0.0000001
    
    setmetatable(object, self)

    return object
end

function uibase:_inherit(props, defaults, type)
    local object = uibase:new(props)

    for k, v in pairs(defaults) do
        if object[k] == nil then
            object[k] = v
        end
    end

    object._type = type

    return object
end

--- Finds the first child element with the name provided
---@param name string Name of element to find
---@return any|nil element Element if found, nil if not
function uibase:get(name)
    for _, element in pairs(self.children) do
        if element.name == name then
            return element
        end
    end

    return nil
end

function _handleListOffsets(self)
    local x, y = 0, 0
    local itemsX, itemsY = 0, 0

    if self.parent.listdirection == "vertical" then
        itemsY = itemsY - self.parent.listpadding
        for _, element in pairs(self.parent.children) do
            local _, _, sX, sY = element:getdrawingcoordinates(true)

            itemsY = itemsY + sY + self.parent.listpadding
            if element._creationorder == self._creationorder then
                itemsX = sX
            end
            if element.layoutorder + element._creationorder < self.layoutorder + self._creationorder and element._creationorder ~= self._creationorder then
                y = y + sY + self.parent.listpadding
            end
        end
    else
        itemsX = itemsX - self.parent.listpadding
        for _, element in pairs(self.parent.children) do
            local _, _, sX, sY = element:getdrawingcoordinates(true)

            itemsX = itemsX + sX + self.parent.listpadding
            if element._creationorder == self._creationorder then
                itemsY = sY
            end
            if element.layoutorder + element._creationorder < self.layoutorder + self._creationorder and element._creationorder ~= self._creationorder then
                x = x + sX + self.parent.listpadding
            end
        end
    end

    local _, _, parentsx, parentsy = self.parent:getdrawingcoordinates(true)

    
    if self.parent.listhalign == "center" then
        x = x + parentsx / 2 - itemsX / 2
    elseif self.parent.listhalign == "right" then
        x = x + parentsx - itemsX
    end

    if self.parent.listvalign == "center" then
        y = y + parentsy / 2 - itemsY / 2
    elseif self.parent.listvalign == "bottom" then
        y = y + parentsy - itemsY
    end

    return x, y
end

--- Gets the screenspace coordinates for position and size
---@return number pX X position
---@return number pY Y position
---@return number sX X size
---@return number sY Y size
function uibase:getdrawingcoordinates(ignoreLayout)
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    local pxextra, pyextra = 0, 0

    if self.parent ~= nil then
        local parentpx, parentpy, parentsx, parentsy = self.parent:getdrawingcoordinates()
        
        local leftPadding = self.parent.leftpadding.offset + self.parent.leftpadding.scale * parentsx
        
        parentpx = parentpx + leftPadding
        parentsx = parentsx - leftPadding - self.parent.rightpadding.offset - self.parent.rightpadding.scale * parentsx
        
        local rightPadding = self.parent.toppadding.offset + self.parent.toppadding.scale * parentsy
        
        parentpy = parentpy + rightPadding
        parentsy = parentsy - rightPadding - self.parent.bottompadding.offset - self.parent.bottompadding.scale * parentsy

        if self.parent.layout == "list" and not ignoreLayout then
            local listx, listy = _handleListOffsets(self)

            parentpx = parentpx + listx
            parentpy = parentpy + listy
        end

        pxextra, pyextra = parentpx, parentpy
        width = parentsx
        height = parentsy
    end

    local sX = self.size.xscale * width + self.size.xoffset
    local sY = self.size.yscale * height + self.size.yoffset
    local pX, pY = pxextra, pyextra
    
    if self.parent == nil or (self.parent.layout ~= "list" and not ignoreLayout) then
        pX = self.position.xscale * width + self.position.xoffset + pxextra - sX * self.anchorpoint.x
        pY = self.position.yscale * height + self.position.yoffset + pyextra - sY * self.anchorpoint.y
    end

    return pX, pY, sX, sY
end

--- Draws the UIBase to the screen
function uibase:draw()  
    local pX, pY, sX, sY = self:getdrawingcoordinates()

    local rX = math.min(sX / 2, self.cornerradius.offset + self.cornerradius.scale * (sX / 2))
    local rY = math.min(sY / 2, self.cornerradius.offset + self.cornerradius.scale * (sY / 2))

    if self.bordersize > 0 then
        love.graphics.setColor(self.bordercolor:get())

        love.graphics.rectangle("fill", pX - self.bordersize, pY - self.bordersize, sX + self.bordersize * 2, sY + self.bordersize * 2, rX + self.bordersize, rY + self.bordersize)
    end

    love.graphics.setColor(self.backgroundcolor:get())
    love.graphics.rectangle("fill", pX, pY, sX, sY, rX, rY)
    love.graphics.setColor(1,1,1,1)
end

-- Handles functions like mouseenter and mouseleave
function uibase:update()
    if self:isvisible() == false then return end
    local mx, my = love.mouse.getPosition()
    local px, py, sx, sy = self:getdrawingcoordinates()
    
    local isColliding = common:checkcollision(px, py, sx, sy, mx, my, 1, 1)
    
    if not self._hovered and isColliding then
        self:mouseenter(mx, my)
        self._hovered = true
    elseif self._hovered and not isColliding then
        self:mouseexit(mx, my)
        self._hovered = false
        self._button1clicked = false
        self._button2clicked = false
    end
    
    if not self._button1clicked and isColliding and love.mouse.isDown(1) then
        self:mousebutton1down()
        self._button1clicked = true
    elseif self._button1clicked and isColliding and not love.mouse.isDown(1) then
        self:mousebutton1up()
        self._button1clicked = false
    end

    if not self._button2clicked and isColliding and love.mouse.isDown(2) then
        self:mousebutton2down()
        self._button2clicked = true
    elseif self._button2clicked and isColliding and not love.mouse.isDown(2) then
        self:mousebutton2up()
        self._button2clicked = false
    end
end

--- Sets the element's parent to another element
---@param element UIBase
function uibase:setparent(element)
    if self == element then
        print("🎈⚠️ Attempted to set an element's parent to itself")
        return
    end

    table.insert(element.children, self)
    self.parent = element
end

--- Calls `setStencil` with the parent's element bounding box in order to clip descendants
---@param parent UIBase
function uibase:stencil(parent)
    if parent == nil then return end

    if parent.clipdescendants then
        love.graphics.stencil(function ()
            love.graphics.rectangle("fill", parent:getdrawingcoordinates())
        end, "replace", 1)

        love.graphics.setStencilTest("greater", 0)
    else
        self:stencil(parent.parent)
    end
end

--- Sets all 4 padding values to one UDim 
---@param udim UDim
function uibase:applyallpadding(udim)
    self.leftpadding = udim
    self.rightpadding = udim
    self.toppadding = udim
    self.bottompadding = udim
end

--- Checks if this element should be visible, based on its ancestry
---@return boolean
function uibase:isvisible()
    local parent = self.parent

    if parent == nil then 
        return self.visible 
    end

    while true do
        if parent.visible == false then
            return false
        end
        if parent.parent == nil then
            break
        end
        parent = parent.parent
    end

    return true
end

return uibase