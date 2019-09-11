function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    score = 0
    kys = false
    gamestart = false
    love.window.setTitle("Try Not To KYS (Or Don't)")
    GAME_START_TEXT = [[This game is still in development (not much of a development I'd say),
Currently you can spawn fire balls (with Space) and control your balls (Ahem!) with the arrow kyes.
And btw you can kill yourself with your own .. your own balls.


                                                        Press Spacebar to continue...]]
    GAME_VERSION = "Game version: 0.000000001 Alpha of the Beta Testing - Not Ready Whatsoever"
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(800, 800, {resizable=false, vsync=true})
    player = {}
    player.front = love.graphics.newImage("front.png")
    player.back = love.graphics.newImage("back.png")
    player.left = love.graphics.newImage("left.png")
    player.right = love.graphics.newImage("right.png")
    player.status = player.front
    player.width = player.status:getWidth()
    player.height = player.status:getHeight()
    player.x = 400
    player.y = 400
    player.rotation = 0
    player.bullets = {}
    player.cooldown = 20
    player.speed = 10
    player.fire = function()
    player.fireposx = 380
    player.fireposy = 400
      if player.cooldown <= 0 then
        player.cooldown = 20
        bullet = {}
        bullet.img = love.graphics.newImage("bullet.png")
        bullet.x = player.fireposx
        bullet.y = player.fireposy
        table.insert(player.bullets, bullet)
      end
    end
  end
  
function love.update(dt)
  if love.keyboard.isDown("space") then
    gamestart = true
  end

  if gamestart == true then

    player.cooldown = player.cooldown - 1
  
    if love.keyboard.isDown("right") then
      player.status = player.right
    elseif love.keyboard.isDown("left") then
      player.status = player.left
    elseif love.keyboard.isDown("up") then
      player.status = player.back
    elseif love.keyboard.isDown("down") then
      player.status = player.front
    end
  
    if love.keyboard.isDown("space") then
      player.fire()
    end
    -- Very Bad Collision Detection For The Player
    for i,b in ipairs(player.bullets) do
      -- First no controls the upper border, second no controls the left border of the player
      if b.y > 325 and b.x > 390 then
        -- First no controls the lower border, second no controls the right border of the player
        if b.y < 455 and b.x < 450 then
          table.remove(player.bullets, i)
          kys = true
        end
      end
    end
  
    for i,b in ipairs(player.bullets) do
      if b.y < 80 or b.x > 800 then
        table.remove(player.bullets, i)
      elseif b.y > 850 or b.x < 0 then
        table.remove(player.bullets, i)
      end
      if player.status == player.back then
        b.y = b.y - 5
      elseif player.status == player.right then
        b.x = b.x + 5
      elseif player.status == player.front then
        b.y = b.y + 5 
      elseif player.status == player.left then
        b.x = b.x - 5
      end
    end
  end
end
  
function love.draw()
  -- game start text
  love.graphics.print(GAME_VERSION, 0, 750)
  if gamestart == false then
    love.graphics.print(GAME_START_TEXT, 0, 0, 0, 1.25)
  end


  -- draw the player
  love.graphics.draw(player.status, player.x, player.y, math.rad(player.rotation), 1.5, 1.5, player.width/2, player.height/2)
  
  
    -- draw bullets
  for _,b in pairs(player.bullets) do
    love.graphics.draw(bullet.img, b.x, b.y, 2, 2)
  end
  -- end game message
  if kys == true then
    love.graphics.print("You Killed Yourself Like A Retard", 400, 400, 0, 4, 4, 95, 40)
  end
    
end