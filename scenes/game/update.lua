function update_game()
    p.sprite = 2

    -- esta variable "t" estara aumentando a travez del juego
    -- se usa para calcular espacios de tiempo entre un evento y otro
    t += 1

    player_controls()

    bullet_timer()
    hiting_border()

    update_enemies()

    go_next_wave()

    collision_enemies_bullets()
    picking()

    animate_flame()
    animate_stars()
    animate_blast()
end