require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    myTheme = yan:NewTheme()
    
    myScreen = yan:Screen()
    myScreen.Enabled = true
    
    testButton = yan:TextButton(myScreen, "CLICK FOR SPROINGYNESS!", 16, "center", "center")
    testButton.Position = UIVector2.new(0.5,0,0.5,0)
    testButton.AnchorPoint = Vector2.new(0.5, 0.5)
    testButton.Size = UIVector2.new(0.5,0,0.5,0)
    testButton.CornerRoundness = 0
    testButton.Color = Color.new(1,1,1,1)
    testButton:ApplyTheme(myTheme)

    myTween = yan:NewTween(testButton, yan:TweenInfo(1, EasingStyle.ElasticOut), {
        Size = UIVector2.new(0.8,0,0.8,0), 
        Color = Color.new(0.2,1,0.2,1),
        CornerRoundness = 30
    })

    myTween2 = yan:NewTween(testButton, yan:TweenInfo(1, EasingStyle.BounceOut), {
        Size = UIVector2.new(0.5,0,0.5,0), 
        Color = Color.new(1,1,1,1),
        CornerRoundness = 30
    })

    testButton.MouseDown = function ()
        myTween:Play()
    end
    
    testImg = yan:Image(myScreen, "/examples/player.png")
    
    testlbl1 = yan:Label(myScreen, "slider bar style", 16, "center", "center")
    testlbl2 = yan:Label(myScreen, "slider fill style", 16, "center", "center")
    testlbl3 = yan:Label(myScreen, "unsproing the button", 16, "center", "center")

    myDropdown = yan:Dropdown(myScreen, testImg, {testlbl1, testlbl2, testlbl3})
    myDropdown.Position = UIVector2.new(0, 10, 0, 10)
    myDropdown.Size = UIVector2.new(0.2,0,0.1,0)
    myDropdown:ApplyTheme(myTheme)
    myDropdown.ZIndex = 10
    mySlider = yan:Slider(myScreen, 0, 100)
    mySlider.Position = UIVector2.new(0, 10, 0.8, 0)
    mySlider.Size = UIVector2.new(0.3,0,0.05,0)
    
    mySlider2 = yan:Slider(myScreen, 4, 9)
    mySlider2.Position = UIVector2.new(0.8, 10, 0.4, 0)
    mySlider2.Size = UIVector2.new(0.05,0,0.4,0)
    mySlider2.Direction = "vertical"
    
    mySlider2.MouseDown = function ()
        print("hai")
    end

    myDropdown.ItemMouseDown = function (element)
        if element.LayoutOrder == 1 then
            mySlider.Style = "bar"
            mySlider2.Style = "bar"
        elseif element.LayoutOrder == 2 then
            mySlider.Style = "fill"
            mySlider2.Style = "fill"
        elseif element.LayoutOrder == 3 then
            myTween2:Play()
        end
        
    end

    myDropdown.ItemMouseUp = function (element)
        
    end

    awesomeFrame = yan:Frame(myScreen)
    awesomeFrame.Position = UIVector2.new(0.2, 0, 0.2, 0)
    awesomeFrame.Size = UIVector2.new(0.5, 0, 0.5, 0)
    awesomeFrame.ZIndex = -1
    awesomeFrame.Color = Color.new(1,0,0,0.5)

    testButton:SetParent(awesomeFrame)
end

function love.update(dt)
    yan:Update(dt)
end

function love.keypressed(key, scancode, rep)
    yan:KeyPressed(key, scancode, rep)
end

function love.textinput(t)
    yan:TextInput(t)
end

function love.wheelmoved(x, y)
    yan:WheelMoved(x,y)
end

function love.draw()
    love.graphics.setBackgroundColor(0.3,0.3,0.3,1)
    yan:Draw()
end

