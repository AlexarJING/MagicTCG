class=require("lib.class")
Gamestate = require "lib.gamestate" --游戏状态库
tween = require("lib.tween")
loveframes = require("lib.loveframes")
require("loadTexture")
makeCard=require("card")
input=require("input")
tempCardCanvas = love.graphics.newCanvas(300, 300)
font = love.graphics.newFont("chinese.ttf", 12)
fontmiddle = love.graphics.newFont("chinese.ttf", 20)
fontbig= love.graphics.newFont("chinese.ttf", 50)
love.graphics.setFont(font)
function love.load(arg) 
    state={}
    state.start=require("start")
    state.game=require("game")
    Gamestate.registerEvents()
    Gamestate.switch(state.game)
    for i=1,5 do
        state.game.gameTable.up.hand.refill()
        state.game.gameTable.down.hand.refill()
    end
    state.game.gameTable.up.hand.reRange()
    state.game.gameTable.down.hand.reRange()
end

function love.update(dt) 
    gameInput=input:test(dt)
    loveframes.update(dt)
end

function love.draw()
end

function love.mousepressed(x, y, button) 
    loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, isrepeat) 
    loveframes.keypressed(key, isrepeat)
end

function love.keyreleased(key)
    loveframes.keyreleased(key) 
end

function love.textinput(text)
    loveframes.textinput(text)
end


--[[
function love.draw() --Callback function used to draw on the screen every frame.
end
function love.quit() --Callback function triggered when the game is closed.
end 
function love.resize(w,h) --Called when the window is resized.
end 
function love.textinput(text) --Called when text has been entered by the user.
end 
function love.threaderror(thread, err ) --Callback function triggered when a Thread encounters an error.
end 
function love.visible() --Callback function triggered when window is shown or hidden.
end 
function love.mousefocus(f)--Callback function triggered when window receives or loses mouse focus.
end
function love.mousepressed(x,y,button) --Callback function triggered when a mouse button is pressed.
end 
function love.mousereleased(x,y,button)--Callback function triggered when a mouse button is released.
end 
function love.errhand(err) --The error handler, used to display error messages.
end 
function love.focus(f) --Callback function triggered when window receives or loses focus.
end 
function love.keypressed(key,isrepeat) --Callback function triggered when a key is pressed.
end
function love.keyreleased(key) --Callback function triggered when a key is released.
end 
function love.run() --The main function, containing the main loop. A sensible default is used when left out.

    if love.math then
        love.math.setRandomSeed(os.time())
        for i=1,3 do love.math.random() end
    end

    if love.event then
        love.event.pump()
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

        if love.window and love.graphics and love.window.isCreated() then
            love.graphics.clear()
            love.graphics.origin()
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end
]]