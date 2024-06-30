local screen = {}
local instance = require("yan.instance.instance")
screen.__index = instance

function screen:New(o)
    o = o or instance:New(o)
    setmetatable(o, self)

    o.Enabled = false
    o.Elements = {}

    function o:AddElement(element)
        table.insert(o.Elements, element)
    end

    function o:Draw()
        if o.Enabled == false then return end

        for _, element in ipairs(o.Elements) do
            element:Draw()
        end
    end
    
    return o
end

return screen