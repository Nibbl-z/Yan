require "yan.uibase"

--- Displays an image
---@class ImageLabel : UIBase
---@field image? string The path to the image
---@field _lastImage? string
---@field _loadedImage? love.Image
imagelabel = uibase:new({})
imagelabel.__index = imagelabel

--- Creates a new ImageLabel
---@param props ImageLabel
function imagelabel:new(props)
    local object = uibase:_inherit(props, {
        image = ""
    }, "ImageLabel")
    setmetatable(object, self)
    
    object._lastImage = object.image

    return object
end

--- Draws the ImageLabel to the screen
function imagelabel:draw()
    uibase.draw(self)
    
    local pX, pY, sX, sY = self:getdrawingcoordinates()
    
    if self._loadedImage == nil or self.image ~= self._lastImage then
        if self._loadedImage ~= nil then
            self._loadedImage:release()
        end
        self._loadedImage = love.graphics.newImage(self.image)
    end

    self._lastImage = self.image

    love.graphics.draw(self._loadedImage, pX, pY, 0, sX / self._loadedImage:getPixelWidth(), sY / self._loadedImage:getPixelHeight())
end

return imagelabel