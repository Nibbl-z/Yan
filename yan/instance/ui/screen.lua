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

        local elements = o.Elements
        table.sort(elements, function(a,b) 
            return (a.ZIndex or 0) < (b.ZIndex or 0) 
        end)

        for _, element in ipairs(elements) do
            element:Draw()
        end
    end
    
    return o
end

return screen