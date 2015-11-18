function love.load()
  player = {}
  player.x = 0
  player.y = 0
  player.move = false
  player.img = love.graphics.newImage("assets/char.png")
  player.front1 = love.graphics.newQuad(2, 1, 12, 26, player.img:getDimensions())
  player.front2 = love.graphics.newQuad(18, 1, 12, 26, player.img:getDimensions())
  player.front3 = love.graphics.newQuad(34, 1, 12, 26, player.img:getDimensions())
  player.back1 = love.graphics.newQuad(2, 29, 12, 26, player.img:getDimensions())
  player.back2 = love.graphics.newQuad(18, 29, 12, 26, player.img:getDimensions())
  player.back3 = love.graphics.newQuad(34, 29, 12, 26, player.img:getDimensions())
  player.right1 = love.graphics.newQuad(2, 57, 12, 26, player.img:getDimensions())
  player.right2 = love.graphics.newQuad(18, 57, 12, 26, player.img:getDimensions())
  player.right3 = love.graphics.newQuad(34, 57, 12, 26, player.img:getDimensions())
  player.left1 = love.graphics.newQuad(2, 85, 12, 26, player.img:getDimensions())
  player.left2 = love.graphics.newQuad(18, 85, 12, 26, player.img:getDimensions())
  player.left3 = love.graphics.newQuad(34, 85, 12, 26, player.img:getDimensions())
  player.sprite = player.front1
  player.front = player.front1
  player.back = player.back1
  player.right = player.right1
  player.left = player.left1
  player.ani = 0
  player.anidelay = 0.2
  player.img:setFilter("nearest", "nearest")
  player.speed = 80
  player.keyboard = "none"
  player.stop = false
  player.cutscene = false
  love.physics.setMeter(32)
  world = love.physics.newWorld(0, 0, true)
  player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  player.shape = love.physics.newRectangleShape(36, 36)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  block = {}
  block.body = love.physics.newBody(world, 200, 200, "static")
  block.shape = love.physics.newRectangleShape(50, 50)
  block.fixture = love.physics.newFixture(block.body, block.shape, 50)
  block.body:setLinearDamping(1)
end
function love.update(dt)
  world:update(dt)
  player.x = player.body:getX()
  player.y = player.body:getY()
  if love.keyboard.isDown("up") and love.keyboard.isDown("down", "left", "right") == false and player.cutscene == false then
    player.keyboard = "up"
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("left", "up", "right") == false and player.cutscene == false then
    player.keyboard = "down"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("down", "up", "right") == false and player.cutscene == false then
    player.keyboard = "left"
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("down", "up", "left") == false and player.cutscene == false then
    player.keyboard = "right"
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("down") and player.cutscene == false then
    player.keyboard = "rightdown"
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") and player.cutscene == false then
    player.keyboard = "rightup"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") and player.cutscene == false then
    player.keyboard = "leftdown"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") and player.cutscene == false then
    player.keyboard = "leftup"
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("down") and player.cutscene == false then
    player.keyboard = "updown"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("right") and player.cutscene == false then
    player.keyboard = "leftright"
  elseif player.cutscene == true then
  else
    player.keyboard = "none"
  end
  if player.keyboard == "up" and player.stop == false then
    player.body:setLinearVelocity(0, -player.speed)
    player.sprite = player.back
    player.move = true
  elseif player.keyboard == "down" and player.stop == false then
    player.body:setLinearVelocity(0, player.speed)
    player.sprite = player.front
    player.move = true
  elseif player.keyboard == "left" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, 0)
    player.sprite = player.left
    player.move = true
  elseif player.keyboard == "right" and player.stop == false then
    player.body:setLinearVelocity(player.speed, 0)
    player.sprite = player.right
    player.move = true
  elseif player.keyboard == "rightdown" and player.stop == false then
    player.body:setLinearVelocity(player.speed, player.speed)
    player.sprite = player.front
    player.move = true
  elseif player.keyboard == "rightup" and player.stop == false then
    player.body:setLinearVelocity(player.speed, -player.speed)
    player.sprite = player.back
    player.move = true
  elseif player.keyboard == "leftdown" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, player.speed)
    player.sprite = player.front
    player.move = true
  elseif player.keyboard == "leftup" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, -player.speed)
    player.sprite = player.back
    player.move = true
  elseif player.keyboard == "updown" and player.stop == false then
    player.body:setLinearVelocity(0, 0)
    player.move = false
  elseif player.keyboard == "leftright" and player.stop == false then
    player.body:setLinearVelocity(0, 0)
    player.move = false
  elseif love.keyboard.isDown("right", "left", "up", "down") == false then
    player.move = false
    player.body:setLinearVelocity(0, 0)
  end
  player.ani = player.ani + dt
  if player.move == true and player.ani < player.anidelay then
    player.front = player.front2
    player.back = player.back2
    player.right = player.right2
    player.left = player.left2
  elseif player.ani >= player.anidelay and player.move == true and player.ani < player.anidelay * 2 then
    player.front = player.front1
    player.back = player.back1
    player.right = player.right1
    player.left = player.left1
  elseif player.ani >= player.anidelay * 2 and player.move == true and player.ani < player.anidelay * 3 then
    player.front = player.front3
    player.back = player.back3
    player.right = player.right3
    player.left = player.left3
  elseif player.ani >= player.anidelay * 3 and player.move == true then
    player.front = player.front1
    player.back = player.back1
    player.right = player.right1
    player.left = player.left1
  elseif player.move == false then
    player.ani = 0
    player.front = player.front1
    player.back = player.back1
    player.right = player.right1
    player.left = player.left1
  else
    player.move = false
  end
  if player.ani >= player.anidelay * 4 then
    player.ani = 0
  end
end
function love.draw()
  love.graphics.rectangle("fill", block.body:getX(), block.body:getY(), 50, 50)
  love.graphics.draw(player.img, player.sprite, player.x, player.y, 0, 3, 3, -2, 12)
end
