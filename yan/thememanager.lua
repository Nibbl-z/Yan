local thememanager = {}

local Color = require("yan.datatypes.color")

function thememanager:NewTheme()
    theme = {
        Color = Color.new(1,1,1,1),
        HoverColor = Color.new(0.7,0.7,0.7,1),
        SelectedColor = Color.new(0.5,0.5,0.5,1),
        ScrollbarColor = Color.new(0,0,0,0.5),
        ScrollbarWidth = 16,

        Font = nil,
        TextColor = Color.new(0,0,0,1),
        PlaceholderTextColor = Color.new(0.3,0.3,0.3,1),

        CornerRoundness = 16
    }
    
    function theme:GetColor()
        return theme.Color.R, theme.Color.G, theme.Color.B, theme.Color.A
    end

    function theme:GetHoverColor()
        return theme.HoverColor.R, theme.HoverColor.G, theme.HoverColor.B, theme.HoverColor.A
    end

    function theme:GetSelectedColor()
        return theme.SelectedColor.R, theme.SelectedColor.G, theme.SelectedColor.B, theme.SelectedColor.A
    end

    function theme:GetTextColor()
        return theme.TextColor.R, theme.TextColor.G, theme.TextColor.B, theme.TextColor.A
    end

    function theme:GetPlaceholderTextColor()
        return theme.PlaceholderTextColor.R, theme.PlaceholderTextColor.G, theme.PlaceholderTextColor.B, theme.PlaceholderTextColor.A
    end

    function theme:GetScrollbarColor()
        return theme.ScrollbarColor.R, theme.ScrollbarColor.G, theme.ScrollbarColor.B, theme.ScrollbarColor.A
    end

    return theme
end

return thememanager