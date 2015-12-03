function love.load()
  love.physics.setMeter(32)
  world = love.physics.newWorld(0, 0, true)
  love.graphics.setBackgroundColor(102, 204, 255)
  assets = {}
  assets.player = love.graphics.newImage("assets/char.png")
  assets.shadow = love.graphics.newImage("assets/shadow.png")
  assets.grass = love.graphics.newImage("assets/dirt.png")
  assets.player:setFilter("nearest", "nearest")
  assets.shadow:setFilter("nearest", "nearest")
  assets.grass:setFilter("nearest", "nearest")
  player = {}
  player.x = 0
  player.y = 0
  player.move = false
  player.front1 = love.graphics.newQuad(2, 1, 12, 26, assets.player:getDimensions())
  player.front2 = love.graphics.newQuad(18, 1, 12, 26, assets.player:getDimensions())
  player.front3 = love.graphics.newQuad(34, 1, 12, 26, assets.player:getDimensions())
  player.back1 = love.graphics.newQuad(2, 29, 12, 26, assets.player:getDimensions())
  player.back2 = love.graphics.newQuad(18, 29, 12, 26, assets.player:getDimensions())
  player.back3 = love.graphics.newQuad(34, 29, 12, 26, assets.player:getDimensions())
  player.right1 = love.graphics.newQuad(2, 57, 12, 26, assets.player:getDimensions())
  player.right2 = love.graphics.newQuad(18, 57, 12, 26, assets.player:getDimensions())
  player.right3 = love.graphics.newQuad(34, 57, 12, 26, assets.player:getDimensions())
  player.left1 = love.graphics.newQuad(2, 85, 12, 26, assets.player:getDimensions())
  player.left2 = love.graphics.newQuad(18, 85, 12, 26, assets.player:getDimensions())
  player.left3 = love.graphics.newQuad(34, 85, 12, 26, assets.player:getDimensions())
  player.sprite = player.front1
  player.front = player.front1
  player.back = player.back1
  player.right = player.right1
  player.left = player.left1
  player.ani = 0
  player.anidelay = 0.2
  player.speed = 120
  player.keyboard = "none"
  player.stop = false
  player.cutscene = false
  player.body = love.physics.newBody(world, 325, 325, "dynamic")
  player.shape = love.physics.newRectangleShape(36, 36)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  island = {}
  island.x, island.y = love.graphics.getDimensions()
  island.x = island.x/2
  island.y = island.y/2
  island.data = {
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    2, 1, 1, 1, 1, 1, 1, 1, 1, 2,
    0, 2, 2, 2, 2, 2, 2, 2, 2, 0
  }
  island.map = love.graphics.newCanvas(160, 64)
  island.map:setFilter("nearest", "nearest")
  island.mapfinish = false
  island.tile = 1
  island.tilex = 0
  island.tiley = 0
  wall = {}
  wall.body1 = love.physics.newBody(world, island.x/2-48-40, island.y/2+48-40, "static")
  wall.shape1 = love.physics.newRectangleShape(78, 32)
  wall.fixture1 = love.physics.newFixture(wall.body1, wall.shape1, 50)
  wall.body1:setLinearDamping(1)
  wall.body2 = love.physics.newBody(world, island.x/2-48-40, island.y/2+48+48+48+12-25, "static")
  wall.shape2 = love.physics.newRectangleShape(78, 40)
  wall.fixture2 = love.physics.newFixture(wall.body2, wall.shape2, 50)
  wall.body2:setLinearDamping(1)
  wall.body3 = love.physics.newBody(world, island.x/2-48-40-48, island.y/2+48-40, "static")
  wall.shape3 = love.physics.newRectangleShape(78, 300)
  wall.fixture3 = love.physics.newFixture(wall.body3, wall.shape3, 50)
  wall.body3:setLinearDamping(1)
  wall.x = 0
  wall.y = 0
  test = {}
  test.body = love.physics.newBody(world, -32, -48)
  test.shape = love.physics.newChainShape(false, 130, 145, 510, 145, 510, 190, 560, 190, 560, 290, 510, 290)
  test.fixture = love.physics.newFixture(test.body, test.shape, 1)
  grass = {}
  grass.grass = love.graphics.newQuad(0, 0, 16, 16, assets.grass:getDimensions())
  grass.dirt = love.graphics.newQuad(0, 16, 32, 16, assets.grass:getDimensions())
  grass.grassdirt = love.graphics.newQuad(0, 16, 16, 16, assets.grass:getDimensions())
end
function love.update(dt)
  world:update(dt)
  player.x = player.body:getX()
  player.y = player.body:getY()
  wall.x = wall.body1:getX()
  wall.y = wall.body1:getY()
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
  if island.mapfinish == false then
    if island.data[island.tile] == 1 then
      love.graphics.setCanvas(island.map)
        love.graphics.draw(assets.grass, grass.grass, island.tilex, island.tiley)
      love.graphics.setCanvas()
    elseif island.data[island.tile] == 2 then
      love.graphics.setCanvas(island.map)
        love.graphics.draw(assets.grass, grass.grassdirt, island.tilex, island.tiley)
      love.graphics.setCanvas()
    end
    if island.tilex == 160 and island.tiley == 64-16 then
      island.mapfinish = true
    end
    if island.tilex ~= 160 then
        island.tilex = island.tilex + 16
    end
    if island.tilex == 160 then
        island.tilex = 0
        island.tiley = island.tiley + 16
    end
    island.tile = island.tile + 1
  end
  love.graphics.draw(island.map, island.x, island.y, 0, 3, 3, 80, 32)
  love.graphics.draw(assets.shadow, player.x, player.y, 0, 3, 3, 0, -10)
  --love.graphics.draw(assets.grass, grass.grassdirt, wall.x, wall.y, 0, 3, 3)
  love.graphics.draw(assets.player, player.sprite, player.x, player.y, 0, 3, 3, -2, 12)
  love.graphics.print(love.mouse.getX() .. ", " .. love.mouse.getY())
end
