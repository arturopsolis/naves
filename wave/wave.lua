function init_wave()
    init_game()
    starExtraSpeed = 2
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
    print("wave " .. wave, 54, 40, 12)
end

function spawn_wave()
    if wave == 1 then
        spawn_enemies(3, 1)
    end
    if wave == 2 then
        spawn_enemies(2, 1)
        spawn_enemies(4, 2)
    end
    if wave == 3 then
        spawn_enemies(2, 1)
        spawn_enemies(3, 2)
        spawn_enemies(3, 3)
    end
    if wave == 4 then
        spawn_enemies(2, 1)
        spawn_enemies(3, 2)
        spawn_enemies(3, 3)
        spawn_enemies(4, 4)
    end
    if wave == 5 then
        spawn_enemies(6, 5)
    end
end

function nextWave()
    wave += 1
    waveTime = 80

    if wave > 4 then
        change_to_scene("win")
    else
        change_to_scene("wave")
    end
end