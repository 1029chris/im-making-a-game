maps = {}
function maps.load()
  map = {}
  map.island = {}
  map.island.x = love.graphics.getWidth()/2
  map.island.y = love.graphics.getHeight()/2
  map.island.data = {
    0, 1, 1, 1, 1, 1, 1, 1, 1, 9999,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9999,
    2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 9999,
    0, 2, 1, 1, 1, 1, 1, 1, 2, 9999,
    0, 0, 2, 2, 2, 2, 2, 2, 9998
  }
  map.island.map = love.graphics.newSpriteBatch(assets.grass, 1000)
  map.finish = false
  map.tile = 1
  map.tilex = 0
  map.tiley = 0
  map.current = {}
  map.current = map.island
end
function maps.update()

end
function maps.draw()
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
end
