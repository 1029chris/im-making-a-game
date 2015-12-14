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
  player.front = {}
  player.back = {}
  player.right = {}
  player.left = {}
  player.front[1] = love.graphics.newQuad(2, 1, 12, 26, assets.player:getDimensions())
  player.front[2] = love.graphics.newQuad(18, 1, 12, 26, assets.player:getDimensions())
  player.front[3] = love.graphics.newQuad(34, 1, 12, 26, assets.player:getDimensions())
  player.back[1] = love.graphics.newQuad(2, 29, 12, 26, assets.player:getDimensions())
  player.back[2] = love.graphics.newQuad(18, 29, 12, 26, assets.player:getDimensions())
  player.back[3] = love.graphics.newQuad(34, 29, 12, 26, assets.player:getDimensions())
  player.right[1] = love.graphics.newQuad(2, 57, 12, 26, assets.player:getDimensions())
  player.right[2] = love.graphics.newQuad(18, 57, 12, 26, assets.player:getDimensions())
  player.right[3] = love.graphics.newQuad(34, 57, 12, 26, assets.player:getDimensions())
  player.left[1] = love.graphics.newQuad(2, 85, 12, 26, assets.player:getDimensions())
  player.left[2] = love.graphics.newQuad(18, 85, 12, 26, assets.player:getDimensions())
  player.left[3] = love.graphics.newQuad(34, 85, 12, 26, assets.player:getDimensions())
  player.sprite = player.front[1]
  player.ani = 0
  player.anidelay = 0.2
  player.speed = 120
  player.keyboard = "none"
  player.stop = false
  player.cutscene = false
  player.body = love.physics.newBody(world, 325, 220, "dynamic")
  player.shape = love.physics.newRectangleShape(36, 36)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.frame = 1
  map = {}
  map.island = {}
  map.island.x, map.island.y = love.graphics.getDimensions()
  map.island.x = map.island.x/2
  map.island.y = map.island.y/2
  map.island.data = {
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 9999,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9999,
    2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 9999,
    0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 9998
  }
  map.island.map = love.graphics.newSpriteBatch(assets.grass, 1000)
  map.finish = false
  map.tile = 1
  map.tilex = 0
  map.tiley = 0
  map.current = {}
  map.current.x = 0
  map.current.y = 0
  map.current.data = {}
  map.current.map = 0
  map.current = map.island
  wall = {}
  wall.body1 = love.physics.newBody(world, map.island.x/2-48-40, map.island.y/2+48-40, "static")
  wall.shape1 = love.physics.newRectangleShape(78, 32)
  wall.fixture1 = love.physics.newFixture(wall.body1, wall.shape1, 50)
  wall.body1:setLinearDamping(1)
  wall.body2 = love.physics.newBody(world, map.island.x/2-48-40, map.island.y/2+48+48+48+12-25, "static")
  wall.shape2 = love.physics.newRectangleShape(78, 40)
  wall.fixture2 = love.physics.newFixture(wall.body2, wall.shape2, 50)
  wall.body2:setLinearDamping(1)
  wall.body3 = love.physics.newBody(world, map.island.x/2-48-40-48, map.island.y/2+48-40, "static")
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
  if love.keyboard.isDown("right") and love.keyboard.isDown("down") and player.cutscene == false then
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
  elseif love.keyboard.isDown("up") and player.cutscene == false then
    player.keyboard = "up"
  elseif love.keyboard.isDown("down") and player.cutscene == false then
    player.keyboard = "down"
  elseif love.keyboard.isDown("left") and player.cutscene == false then
    player.keyboard = "left"
  elseif love.keyboard.isDown("right") and player.cutscene == false then
    player.keyboard = "right"
  elseif player.cutscene == true then
  else
    player.keyboard = "none"
  end
  if player.keyboard == "up" and player.stop == false then
    player.body:setLinearVelocity(0, -player.speed)
    player.sprite = player.back[player.frame]
    player.move = true
  elseif player.keyboard == "down" and player.stop == false then
    player.body:setLinearVelocity(0, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif player.keyboard == "left" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, 0)
    player.sprite = player.left[player.frame]
    player.move = true
  elseif player.keyboard == "right" and player.stop == false then
    player.body:setLinearVelocity(player.speed, 0)
    player.sprite = player.right[player.frame]
    player.move = true
  elseif player.keyboard == "rightdown" and player.stop == false then
    player.body:setLinearVelocity(player.speed, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif player.keyboard == "rightup" and player.stop == false then
    player.body:setLinearVelocity(player.speed, -player.speed)
    player.sprite = player.back[player.frame]
    player.move = true
  elseif player.keyboard == "leftdown" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif player.keyboard == "leftup" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, -player.speed)
    player.sprite = player.back[player.frame]
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
  elseif player.keyboard == "none" then
    player.frame = 1
  end
  player.ani = player.ani + dt
  if player.move == true and player.ani < player.anidelay then
    player.frame = 2
  elseif player.ani >= player.anidelay and player.move == true and player.ani < player.anidelay * 2 then
    player.frame = 1
  elseif player.ani >= player.anidelay * 2 and player.move == true and player.ani < player.anidelay * 3 then
    player.frame = 3
  elseif player.ani >= player.anidelay * 3 and player.move == true then
    player.frame = 1
  elseif player.move == false then
    player.ani = 0
    player.frame = 1
  else
    player.move = false
  end
  if player.ani >= player.anidelay * 4 then
    player.ani = 0
  end
end
function love.draw()
  while map.finish == false do
    if map.current.data[map.tile] == 1 then
      map.current.map:add(grass.grass, map.tilex, map.tiley)
    elseif map.current.data[map.tile] == 2 then
      map.current.map:add(grass.grassdirt, map.tilex, map.tiley)
    end
    if map.current.data[map.tile] == 9998 then
      map.finish = true
    elseif map.current.data[map.tile] ~= 9999 then
        map.tilex = map.tilex + 16
    elseif map.current.data[map.tile] == 9999 then
        map.tilex = 0
        map.tiley = map.tiley + 16
    end
    map.tile = map.tile + 1
  end
  love.graphics.draw(map.current.map, map.current.x, map.current.y, 0, 3, 3, 80, 32)
  love.graphics.draw(assets.shadow, player.x, player.y, 0, 3, 3, 0, -10)
  --love.graphics.draw(assets.grass, grass.grassdirt, wall.x, wall.y, 0, 3, 3)
  love.graphics.draw(assets.player, player.sprite, player.x, player.y, 0, 3, 3, -2, 12)
  love.graphics.print(love.mouse.getX() .. ", " .. love.mouse.getY())
end
