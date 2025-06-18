require "yan.uibase"

--- Displays an image
---@class ImageLabel : UIBase
---@field image love.Image
imagelabel = uibase:new()
imagelabel.__index = imagelabel

--- Creates a new ImageLabel
---@param image string The path to the image to use
function imagelabel:new(image)
    local object = uibase:new()
    setmetatable(object, self)

    object.image = love.graphics.newImage(image)
    return object
end

--- Draws the ImageLabel to the screen
function imagelabel:draw()
    uibase.draw(self)
    
    local pX, pY, sX, sY = self:getdrawingcoordinates()
    
    love.graphics.draw(self.image, pX, pY, 0, sX / self.image:getPixelWidth(), sY / self.image:getPixelHeight())
end

return imagelabel