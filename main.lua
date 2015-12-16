function love.load()
  require("player")
  require("maps")
  love.physics.setMeter(32)
  world = love.physics.newWorld(0, 0, true)
  love.graphics.setBackgroundColor(102, 204, 255)
  love.graphics.setDefaultFilter("nearest")
  system = {
    keyboard = "none"
  }
  assets = {
    player = love.graphics.newImage("assets/char.png"),
    shadow = love.graphics.newImage("assets/shadow.png"),
    grass = love.graphics.newImage("assets/dirt.png")
  }
  grass = {}
  grass.grass = love.graphics.newQuad(0, 0, 16, 16, assets.grass:getDimensions())
  grass.dirt = love.graphics.newQuad(0, 16, 32, 16, assets.grass:getDimensions())
  grass.grassdirt = love.graphics.newQuad(0, 16, 16, 16, assets.grass:getDimensions())
  player.load()
  maps.load()
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
end
function love.update(dt)
  world:update(dt)
  wall.x = wall.body1:getX()
  wall.y = wall.body1:getY()
  if love.keyboard.isDown("right") and love.keyboard.isDown("down") and player.cutscene == false then
    system.keyboard = "rightdown"
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") and player.cutscene == false then
    system.keyboard = "rightup"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") and player.cutscene == false then
    system.keyboard = "leftdown"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") and player.cutscene == false then
    system.keyboard = "leftup"
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("down") and player.cutscene == false then
    system.keyboard = "updown"
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("right") and player.cutscene == false then
    system.keyboard = "leftright"
  elseif love.keyboard.isDown("up") and player.cutscene == false then
    system.keyboard = "up"
  elseif love.keyboard.isDown("down") and player.cutscene == false then
    system.keyboard = "down"
  elseif love.keyboard.isDown("left") and player.cutscene == false then
    system.keyboard = "left"
  elseif love.keyboard.isDown("right") and player.cutscene == false then
    system.keyboard = "right"
  elseif player.cutscene == true then
  else
    system.keyboard = "none"
  end
  player.update(dt)
  if player.ani >= player.anidelay * 4 then
    player.ani = 0
  end
end
function love.draw()
  maps.draw()
  love.graphics.draw(map.current.map, map.current.x, map.current.y, 0, 3, 3, 80, 32)
  --love.graphics.draw(assets.grass, grass.grassdirt, wall.x, wall.y, 0, 3, 3)
  player.draw()
  love.graphics.print(love.mouse.getX() .. ", " .. love.mouse.getY())
end
