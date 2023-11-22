function init_game()
    p = {
        y = 96,
        x = 60,
        h = 8,
        w = 8,
        speed = 2,
        sprite = 2,
        flamespr = 5,
        blast = 0,
        bullet_timer = 0,
        invul = 0,
        score = 0,
        lives = 3
    }

    b = {}
    enemies = {}
    explosions = {}
    particules = {}
    shwaves = {}
    stars = {}

    generate_stars()
end

function update_game()
    p.sprite = 2

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
            new_bullet.x = p.x
            new_bullet.y = p.y - 8
            add(b, new_bullet)

            p.blast = 6
            sfx(0)
            p.bullet_timer = 4
        end
    end

    bullet_timer()
    hiting_border()

    update_enemies()
    update_spawn_enemies()
    collision_enemies_bullets()

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
end