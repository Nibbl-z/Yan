require "yan"

local positioning = require "examples.positioning"
local interactivity = require "examples.interactivity"
local textinputs = require "examples.textinputs"
local updates    = require "examples.updates"
local style      = require "examples.style"
local lists      = require "examples.lists"
local tweening   = require "examples.tweening"

function love.load()
    love.window.setMode(800, 600, {resizable = true})

    page = 1

    function getPage()
        return page
    end

    local pages = {
        positioning(getPage),
        interactivity(getPage),
        textinputs(getPage),
        updates(getPage),
        style(getPage),
        lists(getPage),
        tweening(getPage)
    }

    screen = screen:new {
        main = uibase:new {
            size = UDim2.new(1,0,0.9,0),
            backgroundcolor = Color.new(0,0,0,0),
            children = pages
        },
        
        left = textlabel:new {
            position = UDim2.new(0,0,0.9,0),
            size = UDim2.new(0.2,0,0.1,0),
            textsize = 40,
            text = "<-",
            visible = function ()
                return page ~= 1
            end,
            backgroundcolor = Color.new(0,0,0,0),
            textcolor = Color.new(1,1,1,1),
            mouseenter = function (self)
                self.textcolor = Color.new(0.7,0.7,0.7,1)
            end,
            mouseexit = function (self)
                self.textcolor = Color.new(1,1,1,1)
            end,
            mousebutton1down = function (self)
                page = page - 1
                self.textcolor = Color.new(0.5,0.5,0.5,1)
            end,
            mousebutton1up = function (self)
                self.textcolor = Color.new(0.7,0.7,0.7,1)
            end
        },

        right = textlabel:new {
            position = UDim2.new(1,0,0.9,0),
            anchorpoint = Vector2.new(1,0),
            size = UDim2.new(0.2,0,0.1,0),
            textsize = 40,
            text = "->",
            visible = function ()
                return page ~= #pages
            end,
            backgroundcolor = Color.new(0,0,0,0),
            textcolor = Color.new(1,1,1,1),
            mouseenter = function (self)
                self.textcolor = Color.new(0.7,0.7,0.7,1)
            end,
            mouseexit = function (self)
                self.textcolor = Color.new(1,1,1,1)
            end,
            mousebutton1down = function (self)
                page = page + 1
                self.textcolor = Color.new(0.5,0.5,0.5,1)
            end,
            mousebutton1up = function (self)
                self.textcolor = Color.new(0.7,0.7,0.7,1)
            end
        }
    }

    
end

function love.draw()
    yan:draw()
end

function love.update(dt)
    yan:update(dt)
end

function love.textinput(text)
    yan:textinput(text)
end

function love.keypressed(key)
    yan:keypressed(key)
end