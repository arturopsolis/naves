function init_wave()
    init_game()
end

function update_wave()
    update_game()
    waveTime -= 1
    if waveTime <= 0 then
        change_to_scene("game")
        spawn_wave()
    end
end

function draw_wave()
    draw_game()
    print("wave " .. wave, 54, 40, 7)
end

function spawn_wave()
    if wave == 1 then
        place_enemies({
            { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
            { 1, 1, 1, 1, 0, 0, 1, 1, 1, 1 },
            { 1, 1, 0, 0, 0, 0, 0, 0, 1, 1 },
            { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
        })
    elseif wave == 2 then
        place_enemies({
            { 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 },
            { 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 },
            { 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 },
            { 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 }
        })
    elseif wave == 3 then
        place_enemies({
            { 3, 3, 0, 2, 3, 3, 2, 0, 3, 3 },
            { 3, 3, 0, 2, 2, 2, 2, 0, 3, 3 },
            { 3, 3, 0, 1, 1, 1, 1, 0, 3, 3 },
            { 3, 3, 0, 1, 1, 1, 1, 0, 3, 3 }
        })
    elseif wave == 4 then
        place_enemies({
            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 0, 0, 0, 0, 4, 4, 0, 0, 0, 0 },
            { 0, 0, 0, 0, 4, 4, 0, 0, 0, 0 },
            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        })
    end
end

function place_enemies(level)
    for y = 1, 4 do
        local myline = level[y]
        local myrow = level[x]
        for x = 1, 10 do
            if myline[x] != 0 then
                spawn_enemies(myline[x], x * 12 - 6, 4 + y * 12, x * 3)
            end
        end
    end
end

function nextWave()
    wave += 1
    waveTime = 80

    if wave >= 5 then
        change_to_scene("win")
    else
        change_to_scene("wave")
    end
end