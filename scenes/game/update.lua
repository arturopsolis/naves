function update_game()
    p.sprite = 2

    -- esta variable "t" estara aumentando a travez del jeugo
    -- se usa para calcular espacios de tiempo entre un evento y otro
    t += 1

    player_controls()

    bullet_timer()
    hiting_border()

    update_enemies()
    collision_enemies_bullets()
    picking()

    animate_flame()
    animate_stars()
    animate_blast()
end