player = {}
function player.load()
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
  player.stop = false
  player.cutscene = false
  player.body = love.physics.newBody(world, 325, 220, "dynamic")
  player.shape = love.physics.newRectangleShape(36, 36)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.frame = 1
end
function player.update(dt)
  player.x = player.body:getX()
  player.y = player.body:getY()
  if system.keyboard == "up" and player.stop == false then
    player.body:setLinearVelocity(0, -player.speed)
    player.sprite = player.back[player.frame]
    player.move = true
  elseif system.keyboard == "down" and player.stop == false then
    player.body:setLinearVelocity(0, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif system.keyboard == "left" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, 0)
    player.sprite = player.left[player.frame]
    player.move = true
  elseif system.keyboard == "right" and player.stop == false then
    player.body:setLinearVelocity(player.speed, 0)
    player.sprite = player.right[player.frame]
    player.move = true
  elseif system.keyboard == "rightdown" and player.stop == false then
    player.body:setLinearVelocity(player.speed, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif system.keyboard == "rightup" and player.stop == false then
    player.body:setLinearVelocity(player.speed, -player.speed)
    player.sprite = player.back[player.frame]
    player.move = true
  elseif system.keyboard == "leftdown" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, player.speed)
    player.sprite = player.front[player.frame]
    player.move = true
  elseif system.keyboard == "leftup" and player.stop == false then
    player.body:setLinearVelocity(-player.speed, -player.speed)
    player.sprite = player.back[player.frame]
    player.move = true
  elseif system.keyboard == "updown" and player.stop == false then
    player.body:setLinearVelocity(0, 0)
    player.move = false
  elseif system.keyboard == "leftright" and player.stop == false then
    player.body:setLinearVelocity(0, 0)
    player.move = false
  elseif love.keyboard.isDown("right", "left", "up", "down") == false then
    player.move = false
    player.body:setLinearVelocity(0, 0)
  elseif system.keyboard == "none" then
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
    player.frame = 1
  end
end
function player.draw()
  love.graphics.draw(assets.shadow, player.x, player.y, 0, 3, 3, 0, -10)
  love.graphics.draw(assets.player, player.sprite, player.x, player.y, 0, 3, 3, -2, 12)
end
