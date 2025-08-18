require "yan.datatypes.udim2"
require "yan.datatypes.udim"
require "yan.datatypes.vector2"
require "yan.datatypes.color"

local common = require("yan.common")

--- The base of all interface elements that other elements inherit from
---@class UIBase
---@field type string The type of interface element
---@field visible boolean Should the element be rendered?
---@field position UDim2 Position of the element
---@field size UDim2 Size of the element
---@field anchorpoint Vector2 The origin point where the element will be positioned and scaled from
---@field backgroundcolor Color Background color of the element
---@field clipdescendants boolean Should the children of this element be masked?
---@field leftpadding UDim The amount of padding on children elements on the left side
---@field toppadding UDim The amount of padding on children elements on the top side
---@field rightpadding UDim The amount of padding on children elements on the right side
---@field bottompadding UDim The amount of padding on children elements on the bottom side
---@field zindex number The order that the element is drawn in based on every other element in the Screen
---@field children table A table of children that this element contains
---@field parent UIBase The element that this element is parented to, `nil` if element has no parent
---@field mouseenter fun(self: UIBase, x: number, y: number) Function that runs when the mouse enters the element
---@field mouseexit fun(self: UIBase, x: number, y: number) Function that runs when the mouse exits the element
---@field mousebutton1down fun(self: UIBase) Function that runs when the primary mouse button is clicked within the element
---@field mousebutton1up fun(self: UIBase) Function that runs when the primary mouse button is released within the element
---@field _hovered boolean
---@field _clicked boolean
---@field _creationorder number
uibase = {}
uibase.__index = uibase

--- Creates a new UIBase

local creationIndex = 0

function uibase:new()
    local object = {
        type = "UIBase",
        visible = true,
        position = UDim2.new(0, 0, 0, 0),
        size = UDim2.new(0, 100, 0, 100),
        anchorpoint = Vector2.new(0, 0),
        backgroundcolor = Color.new(1,1,1,1),
        
        clipdescendants = false,
        zindex = 0,
        children = {},
        parent = nil,

        leftpadding = UDim.new(0, 0),
        toppadding = UDim.new(0, 0),
        rightpadding = UDim.new(0, 0),
        bottompadding = UDim.new(0, 0),
        
        mouseenter = function () end,
        mouseexit = function () end,
        mousebutton1down = function () end,
        mousebutton1up = function () end,

        _hovered = false,
        _clicked = false,
        _creationorder = creationIndex
    }
    
    creationIndex = creationIndex + 0.0001
    
    setmetatable(object, self)

    return object
end

--- Gets the screenspace coordinates for position and size
function uibase:getdrawingcoordinates()
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

        pxextra, pyextra = parentpx, parentpy
        width = parentsx
        height = parentsy
    end
    
    local sX = self.size.xscale * width + self.size.xoffset
    local sY = self.size.yscale * height + self.size.yoffset
    
    local pX = self.position.xscale * width + self.position.xoffset + pxextra - sX * self.anchorpoint.x
    local pY = self.position.yscale * height + self.position.yoffset + pyextra - sY * self.anchorpoint.y

    return pX, pY, sX, sY
end

--- Draws the UIBase to the screen
function uibase:draw()
    love.graphics.setColor(self.backgroundcolor:get())
    love.graphics.rectangle("fill", self:getdrawingcoordinates())
    love.graphics.setColor(1,1,1,1)
end

-- Handles functions like mouseenter and mouseleave
function uibase:update()
    local mx, my = love.mouse.getPosition()
    local px, py, sx, sy = self:getdrawingcoordinates()
    
    local isColliding = common:checkcollision(px, py, sx, sy, mx, my, 1, 1)
    
    if not self._hovered and isColliding then
        self:mouseenter(mx, my)
        self._hovered = true
    elseif self._hovered and not isColliding then
        self:mouseexit(mx, my)
        self._hovered = false
        self._clicked = false
    end
    
    if not self._clicked and isColliding and love.mouse.isDown(1) then
        self:mousebutton1down()
        self._clicked = true
    elseif self._clicked and isColliding and not love.mouse.isDown(1) then
        self:mousebutton1up()
        self._clicked = false
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

return uibase