sizeX = 25 --x size of map
sizeY = 25 --y size of map
maxSize = 15 --max number of tiles in a room, ex a 10x10 room or 5x20 room
minSize = 9 --minimum number of tiles in a room, ex a 3x3 room
requireConnections = false --requirement for all rooms to be reachable, if false there may be clusters of rooms not connected to the main chain
numRooms = 5 --number of rooms to generate
maxHallway = 8 --maximum tile length of hallways
wallRules = { --rules to change wall types by after generating the map, work down the table and do not loop
--this does not affect the centre tile as it is comparing tiles around it, the tiles around the centre tiles are the once that should be modified based on the centre tile
    {
        1,2,1, --this is the first index in the table, if the tile to the top left matches the current index set it to 1, top middle set to 2, top right set to 1, this should ignore any tile that does not match the current index
        2,1,2,
        1,1,1,
    },{
        1,1,1,
        2,2,2,
        3,3,3,
    },{
        1,1,2,
        1,3,1,
        2,1,1,
    }
}

function generateFloor(X, Y, maxSize, minSize, requireConnections, numRooms, maxHallway, wallRules)
    -- Validate parameters
    if minSize > maxSize then
        error("minSize cannot be larger than maxSize")
    end
    if numRooms < 1 then
        error("numRooms must be at least 1")
    end
    if X < 5 or Y < 5 then
        error("Map size must be at least 5x5")
    end
    
    -- Initialize map with walls (1)
    local map = {}
    for y = 1, Y do
        map[y] = {}
        for x = 1, X do
            map[y][x] = 1
        end
    end
    
    -- Generate rooms
    local rooms = {}
    local attempts = 0
    local maxAttempts = 100
    
    while #rooms < numRooms and attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Better room dimension calculation
        local maxPossibleWidth = math.min(X - 4, maxSize)  -- Leave border for walls
        local maxPossibleHeight = math.min(Y - 4, maxSize)
        
        -- Ensure we have valid dimensions
        if maxPossibleWidth >= 3 and maxPossibleHeight >= 3 then
            local roomWidth = math.random(3, maxPossibleWidth)
            local roomHeight = math.random(3, maxPossibleHeight)
            
            -- Ensure minimum size and area constraints
            if roomWidth * roomHeight >= minSize and roomWidth * roomHeight <= maxSize then
                -- Safe position calculation
                local maxX = X - roomWidth - 1
                local maxY = Y - roomHeight - 1
                
                -- Ensure valid range for math.random
                if maxX >= 2 and maxY >= 2 then
                    local x = math.random(2, maxX)
                    local y = math.random(2, maxY)
                    
                    -- Check for overlap with existing rooms (with some padding)
                    local overlap = false
                    for _, room in ipairs(rooms) do
                        if x < room.x + room.width + 2 and x + roomWidth + 2 > room.x and
                           y < room.y + room.height + 2 and y + roomHeight + 2 > room.y then
                            overlap = true
                            break
                        end
                    end
                    
                    if not overlap then
                        -- Carve the room
                        for ry = y, y + roomHeight - 1 do
                            for rx = x, x + roomWidth - 1 do
                                if ry >= 1 and ry <= Y and rx >= 1 and rx <= X then
                                    map[ry][rx] = 0
                                end
                            end
                        end
                        
                        -- Add room to list
                        table.insert(rooms, {
                            x = x, 
                            y = y, 
                            width = roomWidth, 
                            height = roomHeight,
                            centerX = math.floor(x + roomWidth / 2),
                            centerY = math.floor(y + roomHeight / 2)
                        })
                    else
                        attempts = attempts - 1
                    end
                else
                    attempts = attempts - 1
                end
            else
                attempts = attempts - 1
            end
        else
            attempts = attempts - 1
        end
    end
    
    -- Connect rooms with hallways
    for i = 1, #rooms - 1 do
        local room1 = rooms[i]
        local room2 = rooms[i + 1]
        
        -- Connect centers with L-shaped hallway
        local x1, y1 = room1.centerX, room1.centerY
        local x2, y2 = room2.centerX, room2.centerY
        
        -- Horizontal then vertical
        if math.random(2) == 1 then
            -- Horizontal segment
            local startX, endX = math.min(x1, x2), math.max(x1, x2)
            for hx = startX, endX do
                if hx >= 1 and hx <= X and y1 >= 1 and y1 <= Y then
                    map[y1][hx] = 0
                end
            end
            -- Vertical segment
            local startY, endY = math.min(y1, y2), math.max(y1, y2)
            for vy = startY, endY do
                if x2 >= 1 and x2 <= X and vy >= 1 and vy <= Y then
                    map[vy][x2] = 0
                end
            end
        else
            -- Vertical then horizontal
            local startY, endY = math.min(y1, y2), math.max(y1, y2)
            for vy = startY, endY do
                if x1 >= 1 and x1 <= X and vy >= 1 and vy <= Y then
                    map[vy][x1] = 0
                end
            end
            -- Horizontal segment
            local startX, endX = math.min(x1, x2), math.max(x1, x2)
            for hx = startX, endX do
                if hx >= 1 and hx <= X and y2 >= 1 and y2 <= Y then
                    map[y2][hx] = 0
                end
            end
        end
    end
    
    -- Apply wall rules
    if wallRules then
        for _, rule in ipairs(wallRules) do
            local newMap = {}
            for y = 1, Y do
                newMap[y] = {}
                for x = 1, X do
                    newMap[y][x] = map[y][x]
                end
            end
            
            for y = 2, Y - 1 do
                for x = 2, X - 1 do
                    if map[y][x] == 1 then -- Only process wall tiles
                        -- Check 3x3 pattern around current tile
                        local patternMatch = true
                        for dy = -1, 1 do
                            for dx = -1, 1 do
                                local ruleIdx = (dy + 1) * 3 + (dx + 1) + 1
                                local ruleValue = rule[ruleIdx]
                                
                                if ruleValue ~= nil then
                                    local checkY, checkX = y + dy, x + dx
                                    if checkY >= 1 and checkY <= Y and checkX >= 1 and checkX <= X then
                                        if map[checkY][checkX] ~= ruleValue then
                                            patternMatch = false
                                            break
                                        end
                                    else
                                        patternMatch = false
                                        break
                                    end
                                end
                            end
                            if not patternMatch then break end
                        end
                        
                        -- If pattern matches, apply the rule to surrounding tiles
                        if patternMatch then
                            for dy = -1, 1 do
                                for dx = -1, 1 do
                                    local ruleIdx = (dy + 1) * 3 + (dx + 1) + 1
                                    local ruleValue = rule[ruleIdx]
                                    
                                    if ruleValue ~= nil then
                                        local applyY, applyX = y + dy, x + dx
                                        if applyY >= 1 and applyY <= Y and applyX >= 1 and applyX <= X then
                                            newMap[applyY][applyX] = ruleValue
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            map = newMap
        end
    end
    
    return map
end

function checkPath(x1, y1, x2, y2, map)
    -- Simple BFS pathfinding to check if there's a path of floor tiles (0) between two points
    if map[y1][x1] ~= 0 or map[y2][x2] ~= 0 then
        return false -- Start or end is not a floor tile
    end
    
    local visited = {}
    for y = 1, #map do
        visited[y] = {}
        for x = 1, #map[y] do
            visited[y][x] = false
        end
    end
    
    local queue = {{x = x1, y = y1}}
    visited[y1][x1] = true
    
    local directions = {
        {dx = 0, dy = -1},  -- up
        {dx = 1, dy = 0},   -- right
        {dx = 0, dy = 1},   -- down
        {dx = -1, dy = 0}   -- left
    }
    
    while #queue > 0 do
        local current = table.remove(queue, 1)
        
        if current.x == x2 and current.y == y2 then
            return true -- Path found
        end
        
        for _, dir in ipairs(directions) do
            local newX, newY = current.x + dir.dx, current.y + dir.dy
            
            if newY >= 1 and newY <= #map and newX >= 1 and newX <= #map[newY] then
                if not visited[newY][newX] and map[newY][newX] == 0 then
                    visited[newY][newX] = true
                    table.insert(queue, {x = newX, y = newY})
                end
            end
        end
    end
    
    return false -- No path found
end

-- Example usage:
-- local map = generateFloor(sizeX, sizeY, maxSize, minSize, requireConnections, numRooms, maxHallway, wallRules)                       

for i = 1, 90 do
    number = math.random()
end

print(Winter.jsonEncode(generateFloor(sizeX, sizeY, maxSize, minSize, requireConnections, numRooms, maxHallway, wallRules)))
print(Winter.jsonEncode(generateFloor(sizeX, sizeY, maxSize, minSize, true, numRooms, maxHallway, wallRules)))