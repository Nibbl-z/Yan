local thememanager = {}

function thememanager:NewTheme()
    theme = {
        Color = {R = 1, G = 1, B = 1, A = 1},
        HoverColor = {R = 0.7, G = 0.7, B = 0.7, A = 1},
        SelectedColor = {R = 0.5, G = 0.5, B = 0.5, A = 1},
        ScrollbarColor = {R = 0, G = 0, B = 0, A = 0.5},
        ScrollbarWidth = 16,

        Font = nil,
        TextColor = {R = 0, G = 0, B = 0, A = 1},
        PlaceholderTextColor = {R = 0.3, G = 0.3, B = 0.3, A = 1},

        CornerRoundness = 16
    }

    function theme:SetColor(r, g, b, a)
        theme.Color = {R = r, G = g, B = b, A = a}
    end

    function theme:SetHoverColor(r, g, b, a)
        theme.HoverColor = {R = r, G = g, B = b, A = a}
    end
    
    function theme:SetSelectedColor(r, g, b, a)
        theme.SelectedColor = {R = r, G = g, B = b, A = a}
    end

    function theme:SetTextColor(r, g, b, a)
        theme.TextColor = {R = r, G = g, B = b, A = a}
    end

    function theme:SetPlaceholderTextColor(r, g, b, a)
        theme.PlaceholderTextColor = {R = r, G = g, B = b, A = a}
    end

    function theme:SetScrollbarColor(r, g, b, a)
        theme.ScrollbarColor = {R = r, G = g, B = b, A = a}
    end
    
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