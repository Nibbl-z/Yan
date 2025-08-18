require "yan"

function love.load()
    love.window.setMode(800, 600, {resizable = true})
    
    mainScreen = screen:new()

    titleLabel = textlabel:new("yan", 50, "center", "center")
    titleLabel.size = UDim2.new(1,0,0.1,0)
    titleLabel.backgroundcolor = Color.new(0,0,0,0)
    titleLabel.textcolor = Color.new(1,1,1,1)

    subtitleLabel = textlabel:new("a simple ui library for love2d based on roblox's ui system", 20, "center", "center")
    subtitleLabel.size = UDim2.new(1,0,0.06,0)
    subtitleLabel.position = UDim2.new(0,0,0.09,0)
    subtitleLabel.backgroundcolor = Color.new(0,0,0,0)
    subtitleLabel.textcolor = Color.new(1,1,1,1)

    mainFrame = uibase:new()
    mainFrame.position = UDim2.new(0.5,0,0.5,0)
    mainFrame.size = UDim2.new(0.7,0,0.7,0)
    mainFrame.anchorpoint = Vector2.new(0.5,0.5)
    mainFrame.backgroundcolor = Color.new(0.3,0.3,0.3,1)
    mainFrame:applyallpadding(UDim.new(0,20))

    currentPage = 1

    leftBtn = textlabel:new("<", 20, "center", "center")
    leftBtn.size = UDim2.new(0.1,0,1,0)
    leftBtn.position = UDim2.new(-0.1,-30,0,0)
    leftBtn:setparent(mainFrame)
    leftBtn.backgroundcolor = Color.new(0.3,0.3,0.3,1)

    rightBtn = textlabel:new(">", 20, "center", "center")
    rightBtn.size = UDim2.new(0.1,0,1,0)
    rightBtn.position = UDim2.new(1,30,0,0)
    rightBtn:setparent(mainFrame)
    rightBtn.backgroundcolor = Color.new(0.3,0.3,0.3,1)

    leftBtn.mouseenter = function () leftBtn.backgroundcolor = Color.new(0.2,0.2,0.2,1) end
    leftBtn.mouseexit = function () leftBtn.backgroundcolor = Color.new(0.3,0.3,0.3,1) end
    rightBtn.mouseenter = function () rightBtn.backgroundcolor = Color.new(0.2,0.2,0.2,1) end
    rightBtn.mouseexit = function () rightBtn.backgroundcolor = Color.new(0.3,0.3,0.3,1) end

    leftBtn.mousebutton1down = function ()
        if currentPage > 1 then
            currentPage = currentPage - 1
        end
    end

    rightBtn.mousebutton1down = function ()
        if currentPage < 3 then
            currentPage = currentPage + 1
        end
    end

    demo1 = {}
    
    demo1title = textlabel:new("demo 1: buttons", 40, "center", "center")
    demo1title.size = UDim2.new(1,0,0.07,0)
    demo1title.backgroundcolor = Color.new(0,0,0,0)
    demo1title.textcolor = Color.new(1,1,1,1)
    demo1title:setparent(mainFrame)

    demo1description = textlabel:new("any ui instance can be a button, including textlabels, textinputs, and imagelabels. all you need to do is pass a function into any element's mouseenter, mouseexit, mousebutton1down, or mousebutton1up field", 15, "center", "center")
    demo1description.position = UDim2.new(0,0,0.07,0)
    demo1description.size = UDim2.new(1,0,0.4,0)
    demo1description.backgroundcolor = Color.new(0,0,0,0)
    demo1description.textcolor = Color.new(1,1,1,1)
    demo1description:setparent(mainFrame)
    
    demo1btn = textlabel:new("i'm a button! click me!!!", 20, "center", "center")
    demo1btn.position = UDim2.new(0,10,0.5,10)
    demo1btn.size = UDim2.new(0.5,-20,0.5,-10)
    demo1btn:setparent(mainFrame)

    demo1btn.mouseenter = function () demo1btn.backgroundcolor = Color.new(0.8,0.8,0.8,1) end
    demo1btn.mouseexit = function () 
        demo1btn.backgroundcolor = Color.new(1,1,1,1)
        demo1btn.text = "i'm a button! click me!!!"
    end
    demo1btn.mousebutton1down = function ()
        demo1btn.backgroundcolor = Color.new(0.6,0.6,0.6,1)
        demo1btn.text = "thank you!!! :D"
    end
    demo1btn.mousebutton1up = function ()
        demo1btn.backgroundcolor = Color.new(0.8,0.8,0.8,1)
        demo1btn.text = "i'm a button! click me!!!"
    end

    demo1imagebtn = imagelabel:new("examples/example_btn.png")
    demo1imagebtn.position = UDim2.new(0.5,10,0.5,10)
    demo1imagebtn.size = UDim2.new(0.5,-20,0.5,-10)
    demo1imagebtn:setparent(mainFrame)
    
    demo1imagebtn.mousebutton1down = function ()
        demo1imagebtn:setimage("examples/example_btn_clicked.png")
    end
    demo1imagebtn.mousebutton1up = function ()
        demo1imagebtn:setimage("examples/example_btn.png")
    end

    table.insert(demo1, demo1title)
    table.insert(demo1, demo1description)
    table.insert(demo1, demo1btn)
    table.insert(demo1, demo1imagebtn)

    demo2 = {}

    demo2title = textlabel:new("demo 2: positioning/parenting/padding", 17, "center", "center")
    demo2title.size = UDim2.new(1,0,0.07,0)
    demo2title.backgroundcolor = Color.new(0,0,0,0)
    demo2title.textcolor = Color.new(1,1,1,1)
    demo2title:setparent(mainFrame)

    demo2description = textlabel:new("ui elements are positioned with udim2s, which have an x and y axis, with each axis having scale (based off of screen size) and offset (based off of pixels). elements can be parented to other elements, which makes the scale property in their position/scale relative to the size of the parent element instead of the screen size, allowing for easy positioning of elements. this also allows for the window to be rescaled and still look as intended!! you can also apply padding to elements which will add some spacing to the elements inside", 15, "center", "center")
    demo2description.position = UDim2.new(0,0,0.07,5)
    demo2description.size = UDim2.new(1,0,0.5,0)
    demo2description.backgroundcolor = Color.new(0,0,0,0)
    demo2description.textcolor = Color.new(1,1,1,1)
    demo2description:setparent(mainFrame)

    demo2container = uibase:new()
    demo2container.position = UDim2.new(0,0,0.6,0)
    demo2container.size = UDim2.new(1,0,0.4,0)
    demo2container.backgroundcolor = Color.new(0.6,0.2,1,1)
    demo2container:setparent(mainFrame)
    demo2container:applyallpadding(UDim.new(0,5))

    demo2container2 = textlabel:new("this label has 0.75 x scale and 0.75 y scale, it's container has 5px of padding, and the niko oneshot is 80px offset by 80px offset", 15, "center", "center")
    demo2container2.size = UDim2.new(0.75,0,0.75,0)
    demo2container2:setparent(demo2container)

    demo2image = imagelabel:new("examples/example_image.png")
    demo2image.position = UDim2.new(1,0,1,0)
    demo2image.anchorpoint = Vector2.new(1,1)
    demo2image.size = UDim2.new(0,80,0,80)
    demo2image:setparent(demo2container)

    table.insert(demo2, demo2title)
    table.insert(demo2, demo2description)
    table.insert(demo2, demo2container)
    table.insert(demo2, demo2container2)
    table.insert(demo2, demo2image)

    demo3 = {}

    demo3title = textlabel:new("demo 3: textinputs", 30, "center", "center")
    demo3title.size = UDim2.new(1,0,0.07,0)
    demo3title.backgroundcolor = Color.new(0,0,0,0)
    demo3title.textcolor = Color.new(1,1,1,1)
    demo3title:setparent(mainFrame)

    demo3description = textlabel:new("yan includes textinput elements! they let you type in text (duh), and it works with special characters like shift+2 for @. the label below the textinput copies the text in the textinput", 15, "center", "center")
    demo3description.position = UDim2.new(0,0,0.07,5)
    demo3description.size = UDim2.new(1,0,0.3,0)
    demo3description.backgroundcolor = Color.new(0,0,0,0)
    demo3description.textcolor = Color.new(1,1,1,1)
    demo3description:setparent(mainFrame)

    demo3textinput = textinput:new("type stuff here!!", 30, "center", "center")
    demo3textinput.position = UDim2.new(0,0,0.4,0)
    demo3textinput.size = UDim2.new(1,0,0.2,0)
    demo3textinput:setparent(mainFrame)
    
    demo3textinput.mouseenter = function () demo3textinput.backgroundcolor = Color.new(0.8,0.8,0.8,1) end
    demo3textinput.mouseexit = function () demo3textinput.backgroundcolor = Color.new(1,1,1,1) end

    demo3label = textlabel:new("", 20, "left", "top")
    demo3label.position = UDim2.new(0,0,0.6,10)
    demo3label.size = UDim2.new(1,0,0.2,0)
    demo3label:setparent(mainFrame)

    table.insert(demo3, demo3title)
    table.insert(demo3, demo3description)
    table.insert(demo3, demo3textinput)
    table.insert(demo3, demo3label)

    mainScreen:addelements({
        titleLabel, mainFrame, subtitleLabel, leftBtn, rightBtn, 
        demo1title, demo1description, demo1btn, demo1imagebtn, 
        demo2title, demo2description, demo2container, demo2container2, demo2image,
        demo3title, demo3description, demo3textinput, demo3label
    })
    pages = {
        demo1,
        demo2,
        demo3
    }
end

function love.update()
    for _, element in ipairs(pages[currentPage]) do
        element.visible = true
    end

    for i = 1, #pages do
        if i ~= currentPage then
            for _, element in ipairs(pages[i]) do
                element.visible = false
            end
        end
    end

    demo3label.text = demo3textinput.text

    mainScreen:update()
end

function love.draw()
    mainScreen:draw()
end

function love.textinput(text)
    mainScreen:textinput(text)
end

function love.keypressed(key)
    mainScreen:keypressed(key)
end