function init_game()
    starExtraSpeed = 0
    t = 0
end

function update_game()
    p.sprite = 2

    -- esta variable "t" estara aumentando a travez del jeugo
    -- se usa para calcular espacios de tiempo entre un evento y otro
    t += 1

    if btn(0) then
        p.x -= p.speed
        p.sprite = 1
    end
    if btn(1) then
        p.x += p.speed
        p.sprite = 3
    end
    if btn(2) then
        p.y -= p.speed
    end
    if btn(3) then
        p.y += p.speed
    end
    if btn(❎) then
        if p.bullet_timer <= 0 then
            --new bullet
            local new_bullet = {}
            new_bullet.x = p.x + 1
            new_bullet.y = p.y - 8
            new_bullet.h = 6
            new_bullet.w = 6
            add(b, new_bullet)

            sfx(0)
            p.blast = 5
            p.bullet_timer = 4
        end
    end

    bullet_timer()
    hiting_border()

    update_enemies()
    collision_enemies_bullets()
    picking()

    animate_flame()
    animate_stars()
    animate_blast()
end

function draw_game()
    cls(0)
    draw_stars()
    draw_player()
    draw_ship_flame()
    draw_blast()
    draw_score()
    draw_bullets()
    draw_enemies()
    draw_explosions()
    draw_shock_waves()
    draw_particules()
    draw_debug()
end