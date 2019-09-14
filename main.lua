function love.load()
  ico = love.image.newImageData("bullet.png")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setIcon(ico)
  score = 0
  highscore = 0
  kys = false -- killed yourself
  kbs = false -- killed by shadows
  zbutton = {}
  zbutton.y = 50
  zbutton.img = love.graphics.newImage("z.png")
  xbutton = {}
  xbutton.img = love.graphics.newImage("x.png")
  xbutton.y = 100
  shooting_key = "z"
  kys_key = "x"
  random_int = 1
  gamestart = false
  love.window.setTitle("Try Not To KYS (Or Don't)")
  GAME_START_TEXT = [[This game is still in development (another way to say that it looks bad and has bugs),
The goal of this game is to kill the approaching ghosts before they reach you. Shoot the ghosts with 
either "Z" or "X". The shooting button changes after a random amount of time, and if you use 
the wrong button you will Kill Yourself. 


                                                    Press Spacebar to Continue or Restart...]]
  GAME_VERSION = "Game version: 0.03"
  background = love.graphics.newImage("background1.png")
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 700, {resizable=false, vsync=true})
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
  button_cooldown = 95
  BULLET_SPEED = 5
  player.bulletsL = {}
  player.bulletsR = {}
  player.bulletsU = {}
  player.bulletsD = {}
  player.cooldown = 20
  player.fireposx = 380
  player.fireposy = 400
  player.fireL = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.img = love.graphics.newImage("bullet.png")
      bullet.x = player.fireposx
      bullet.y = player.fireposy
      table.insert(player.bulletsL, bullet)
    end
  end
  player.fireR = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.img = love.graphics.newImage("bullet.png")
      bullet.x = player.fireposx + 100
      bullet.y = player.fireposy
      table.insert(player.bulletsR, bullet)
    end
  end
  player.fireU = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.img = love.graphics.newImage("bullet.png")
      bullet.x = player.fireposx + 35
      bullet.y = player.fireposy - 40
      table.insert(player.bulletsU, bullet)
    end
  end
  player.fireD = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.img = love.graphics.newImage("bullet.png")
      bullet.x = player.fireposx + 35
      bullet.y = player.fireposy
      table.insert(player.bulletsD, bullet)
    end
  end
  shadowsSpeed = .5
  world = {}
  world.shadowsL = {}
  spawnLcooldown = 10
  world.spawnL = function()
    if spawnLcooldown <= 0 then
      spawnLcooldown = 72
      shadowL = {}
      shadowL.img = love.graphics.newImage("shadowL.png")
      shadowL.x = 5
      shadowL.y = 400
      shadowL.width = shadowL.img:getWidth()
      shadowL.height = shadowL.img:getHeight()
      shadowL.rightborder = shadowL.x + shadowL.width
      table.insert(world.shadowsL, shadowL)
    end
  end
  world.shadowsR = {}
  spawnRcooldown = 81
  world.spawnR = function()
    if spawnRcooldown <= 0 then
      spawnRcooldown = 78
      shadowR = {}
      shadowR.img = love.graphics.newImage("shadowR.png")
      shadowR.x = 805
      shadowR.y = 400
      shadowR.width = shadowR.img:getWidth()
      shadowR.height = shadowR.img:getHeight()
      shadowR.leftborder = shadowR.x - 20
      table.insert(world.shadowsR, shadowR)
    end
  end
  world.shadowsU = {}
  spawnUcooldown = 75
  world.spawnU = function()
    if spawnUcooldown <= 0 then
      spawnUcooldown = 81
      shadowU = {}
      shadowU.img = love.graphics.newImage("shadowU.png")
      shadowU.x = 400
      shadowU.y = -5
      shadowU.width = shadowU.img:getWidth()
      shadowU.height = shadowU.img:getHeight()
      shadowU.lowerborder = shadowU.y + 45
      table.insert(world.shadowsU, shadowU)
    end
  end
  world.shadowsD = {}
  spawnDcooldown = 76
  world.spawnD = function()
    if spawnDcooldown <= 0 then
      spawnDcooldown = 60
      shadowD = {}
      shadowD.img = love.graphics.newImage("shadowD.png")
      shadowD.x = 400
      shadowD.y = 805
      shadowD.width = shadowD.img:getWidth()
      shadowD.height = shadowD.img:getHeight()
      shadowD.upperborder = shadowD.y - 45
      table.insert(world.shadowsD, shadowD)
    end
  end
end
-- Collision Detection Functions 
  -- LEFT
function detectCollisonL(shadows, bullets)
  for i,s in ipairs(shadows) do 
    for i,b in ipairs(bullets) do
      if b.x <= s.rightborder then
        table.remove(bullets, i)
        table.remove(shadows, i)
        score = score + 1
      end  
    end
  end
end
  -- RIGHT
function detectCollisonR(shadows, bullets)
  for i,s in ipairs(shadows) do 
    for i,b in ipairs(bullets) do
      if b.x >= s.leftborder then
        table.remove(bullets, i)
        table.remove(shadows, i)
        score = score + 1
      end  
    end
  end
end
  -- UP
function detectCollisonU(shadows, bullets)
  for i,s in ipairs(shadows) do 
    for i,b in ipairs(bullets) do
      if b.y <= s.lowerborder then
        table.remove(bullets, i)
        table.remove(shadows, i)
        score = score + 1
      end  
    end
  end
end

  -- DOWN
function detectCollisonD(shadows, bullets)
  for i,s in ipairs(shadows) do 
    for i,b in ipairs(bullets) do
      if b.y >= s.upperborder then
        table.remove(bullets, i)
        table.remove(shadows, i)
        score = score + 1
      end  
    end
  end
end

-- Update Highscore Function
function updateHighscore()
  if highscore < score then
    highscore = score
  end
end

-- Changing Keys Function
function changeKeys()
  if shooting_key == "z" then
    zbutton.y = 100
    xbutton.y = 50
    shooting_key = "x"
    kys_key = "z"
  elseif shooting_key == "x" then
    xbutton.y = 100
    zbutton.y = 50
    shooting_key = "z"
    kys_key = "x"
  end
end

function resetShadowSpeed()
  shadowsSpeed = 0.7
end

function love.update(dt)
  if love.keyboard.isDown("space") then
    gamestart = true
  end

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  -- Increasing Shadows' Speed Overtime
  shadowsSpeed = shadowsSpeed + (.02 / 60)

  -- Changing Keys
  if not love.keyboard.isDown(shooting_key) then
    if love.keyboard.isDown(kys_key) then
      updateHighscore()
      kys = true
      gamestart = false
      score = 0
      resetShadowSpeed()
    elseif button_cooldown <=0 then
      changeKeys()
      button_cooldown = math.random (120, 450)
    end
  end
  -- Calling Fire Functions
  if love.keyboard.isDown(shooting_key) then
    if player.status == player.right then
      player.fireR()
    elseif player.status == player.left then
      player.fireL()
    elseif player.status == player.back then
      player.fireU()
    elseif player.status == player.front then
      player.fireD()
    end
  end


  detectCollisonL(world.shadowsL, player.bulletsL)
  detectCollisonR(world.shadowsR, player.bulletsR)
  detectCollisonD(world.shadowsD, player.bulletsD)
  detectCollisonU(world.shadowsU, player.bulletsU)

  -- Despawning Enemies

  if gamestart == false or kys == true then
    for i,s in ipairs(world.shadowsL) do
      table.remove(world.shadowsL, i)
      resetShadowSpeed()
    end


    for i,s in ipairs(world.shadowsR) do
      table.remove(world.shadowsR, i)
      resetShadowSpeed()
    end


    for i,s in ipairs(world.shadowsU) do
      table.remove(world.shadowsU, i)
      resetShadowSpeed()
    end


    for i,s in ipairs(world.shadowsD) do
      table.remove(world.shadowsD, i)
      resetShadowSpeed()
    end
  end

  -- Loop At Game Start

  if gamestart == true then
    kys = false
    kbs = false


    player.cooldown = player.cooldown - 1
    spawnLcooldown = spawnLcooldown - 1
    spawnRcooldown = spawnRcooldown - 1
    spawnUcooldown = spawnUcooldown - 1
    spawnDcooldown = spawnDcooldown - 1
    button_cooldown = button_cooldown -1
    
    -- spawning shadows

    if spawnLcooldown <= 0 then 
      world.spawnL()
      spawnLcooldown = math.random(150, 500)
    end

    if spawnRcooldown <= 0 then 
      world.spawnR()
      spawnRcooldown = math.random(150, 500)
    end

    if spawnUcooldown <= 0 then 
      world.spawnU()
      spawnUcooldown = math.random(150, 500)
    end

    if spawnDcooldown <= 0 then 
      world.spawnD()
      spawnDcooldown = math.random(150, 500)
    end
  
    if love.keyboard.isDown("right") then
      player.status = player.right
    elseif love.keyboard.isDown("left") then
      player.status = player.left
    elseif love.keyboard.isDown("up") then
      player.status = player.back
    elseif love.keyboard.isDown("down") then
      player.status = player.front
    end
  
    -- Very Bad Collision Detection For ShadowsL and Player
    for i,s in ipairs(world.shadowsL) do
      -- Checks against left border of the player
      if s.x > 350 then
        table.remove(world.shadowsL, i)
        updateHighscore()
        kbs = true
        gamestart = false
        score = 0
      end
    end

    -- Very Bad Collision Detection For ShadowsR and Player
    for i,s in ipairs(world.shadowsR) do
      -- Checks against left border of the player
      if s.x < 450 then
        table.remove(world.shadowsR, i)
        updateHighscore()
        kbs = true
        gamestart = false
        score = 0
      end
    end

    -- Very Bad Collision Detection For ShadowsU and Player
    for i,s in ipairs(world.shadowsU) do
      -- Checks against left border of the player
      if s.y > 370 then
        table.remove(world.shadowsU, i)
        updateHighscore()
        kbs = true
        gamestart = false
        score = 0
      end
    end

    -- Very Bad Collision Detection For ShadowsD and Player
    for i,s in ipairs(world.shadowsD) do
      -- Checks against left border of the player
      if s.y < 490 then
        table.remove(world.shadowsD, i)
        updateHighscore()
        kbs = true
        gamestart = false
        score = 0
      end
    end
    -- Updating Shadows Position 

    for _,s in pairs(world.shadowsL) do
      s.x = s.x + shadowsSpeed
      s.rightborder = s.rightborder + shadowsSpeed
    end

    for _,s in pairs(world.shadowsR) do
      s.x = s.x - shadowsSpeed
      s.leftborder = s.leftborder - shadowsSpeed
    end

    for _,s in ipairs(world.shadowsD) do
      s.y = s.y - shadowsSpeed
      s.upperborder = s.upperborder - shadowsSpeed
    end

    for _,s in ipairs(world.shadowsU) do
      s.y = s.y + shadowsSpeed
      s.lowerborder = s.lowerborder + shadowsSpeed
    end

    -- Removing Bullets out of window border
    for i,b in ipairs(player.bulletsL) do
      if b.x < -10 then
        table.remove(player.bulletsL, i)
      end
    end
    for i,b in ipairs(player.bulletsR) do
      if b.x > 810 then
        table.remove(player.bulletsR, i)
      end
    end
    for i,b in ipairs(player.bulletsU) do
      if b.y < -10 then
        table.remove(player.bulletsU, i)
      end
    end
    for i,b in ipairs(player.bulletsD) do
      if b.y > 810 then
        table.remove(player.bulletsD, i)
      end
    end  


    for _,b in pairs(player.bulletsL) do
      b.x = b.x - BULLET_SPEED
    end
    for _,b in pairs(player.bulletsR) do
      b.x = b.x + BULLET_SPEED
    end
    for _,b in pairs(player.bulletsU) do
      b.y = b.y - BULLET_SPEED
    end
    for _,b in pairs(player.bulletsD) do
      b.y = b.y + BULLET_SPEED
    end
    
  end
end
  
function love.draw()
  love.graphics.draw(background, 0, 0, 0, 7, 7)
  -- game start text
  love.graphics.print(GAME_VERSION, 0, 680)
  if gamestart == false then
    love.graphics.print(GAME_START_TEXT, 0, 70, 0, 1.25)
  end

  if gamestart == true then

    love.graphics.print("To Shoot", 75, 55, 0, 2, 2)
    love.graphics.print("To KYS", 75, 105, 0, 2, 2)

    
    -- Drawing Score
    love.graphics.print("Score:  " .. score, 600, 70, 0, 2)
    love.graphics.print("Highscore:  " .. highscore, 550, 620, 0, 2)
    -- Drawing Controls
    if shooting_key == "z" then 
      love.graphics.draw(zbutton.img, 20, zbutton.y, 0, 1, 1)
      love.graphics.draw(xbutton.img, 20, xbutton.y, 0, 1, 1)
    elseif shooting_key == "x" then
      love.graphics.draw(xbutton.img, 20, xbutton.y, 0, 1, 1)
      love.graphics.draw(zbutton.img, 20, zbutton.y, 0, 1, 1)
    end
    -- Drawing Shadows
    for _,s in pairs(world.shadowsL) do
      love.graphics.draw(shadowL.img, s.x, s.y, 0, 1, 1, shadowL.width/2, shadowL.height/2)
    end
    for _,s in pairs(world.shadowsR) do
      love.graphics.draw(shadowR.img, s.x, s.y, 0, 1, 1, shadowR.width/2, shadowR.height/2)
    end
    for _,s in pairs(world.shadowsD) do
      love.graphics.draw(shadowD.img, s.x, s.y, 0, 1, 1, shadowD.width/2, shadowD.height/2)
    end
    for _,s in pairs(world.shadowsU) do
      love.graphics.draw(shadowU.img, s.x, s.y, 0, 1, 1, shadowU.width/2, shadowU.height/2)
    end
  end

  -- draw the player
  love.graphics.draw(player.status, player.x, player.y, math.rad(player.rotation), 1.5, 1.5, player.width/2, player.height/2)
  
  
    -- draw bullets
  for _,b in pairs(player.bulletsL) do
    love.graphics.draw(bullet.img, b.x, b.y, 2, 2)
  end
  for _,b in pairs(player.bulletsR) do
    love.graphics.draw(bullet.img, b.x, b.y, 2, 2)
  end
  for _,b in pairs(player.bulletsU) do
    love.graphics.draw(bullet.img, b.x, b.y, 2, 2)
  end
  for _,b in pairs(player.bulletsD) do
    love.graphics.draw(bullet.img, b.x, b.y, 2, 2)
  end
  -- end game message
  if kys == true then
    love.graphics.print("You Killed Yourself Like A Retard", 400, 400, 0, 4, 4, 95, 40)
  elseif kbs == true then
    love.graphics.print("Shadows Killed You Like A Retard", 400, 400, 0, 3.5, 3.5, 100, 40)
  end
    
end