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
        score = 0,
        lives = 3,
        invul = 0
    }

    bultimer = 0

    --enemies
    enemies = {}

    --bullets
    b = {}

    --explosions
    explosions = {}

    --particules
    particules = {}

    --shock waves
    shwaves = {}

    --stars
    stars = {}

    for i = 1, 60 do
        local new_star = {}
        local colors = { 6, 13, 5, 1 }

        new_star.x = flr(rnd(128))
        new_star.y = flr(rnd(128))
        new_star.speed = rnd(4)

        if new_star.speed > 3 then
            new_star.colr = colors[1]
        elseif new_star.speed > 2 then
            new_star.colr = colors[2]
        elseif new_star.speed > 1 then
            new_star.colr = colors[3]
        else
            new_star.colr = colors[4]
        end

        add(stars, new_star)
    end
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
        if bultimer <= 0 then
            --new bullet
            local new_bullet = {}
            new_bullet.x = p.x
            new_bullet.y = p.y - 8
            add(b, new_bullet)

            p.blast = 6 --antes muzzle
            sfx(0)
            bultimer = 4
        end
    end
    bultimer -= 1

    --animate flame
    p.flamespr += 1
    if p.flamespr >= 9 then
        p.flamespr = 5
    end

    --animate blast
    if p.blast > 0 then
        p.blast = p.blast - 1
    end

    --checking if we hit the border
    if p.x > 120 then
        p.x = 120
    end
    if p.x < 0 then
        p.x = 0
    end

    --spawn enemies
    spawn_enemies(5)

    --stars
    animate_stars()

    --update enemies
    for enemy in all(enemies) do
        if enemy.y <= 128 then
            enemy.y += 1
        else
            enemy.y = -8
            enemy.x = rnd(128)
        end
        if enemy.sprite >= 39 then
            enemy.sprite = 36
        else
            enemy.sprite += 1
        end
        if p.invul <= 0 then
            if collide(p, enemy) then
                explode(p.x + 4, p.y + 4, true)
                p.lives -= 1
                p.invul = 300
                sfx(1)
                if p.lives <= 0 then
                    change_scene("gameover")
                end
            end
        end
        p.invul -= 1
    end

    --collision enemies and bullets
    for enemy in all(enemies) do
        for bullet in all(b) do
            if collide(enemy, bullet) then
                del(b, bullet)
                smol_shwave(bullet.x, bullet.y)
                smol_spark(bullet.x, bullet.y)
                if enemy.live <= 0 then
                    del(enemies, enemy)
                    explode(enemy.x + 4, enemy.y + 4, false)
                    p.score += 100
                    sfx(3)
                end
                enemy.sprite = 40
                enemy.live -= 1
                sfx(2)
                break
            end
        end
    end
end

function draw_game()
    cls(0)

    --draw stars
    draw_stars()

    --draw player
    spr(p.sprite, p.x, p.y)

    --draw bullets
    for mybull in all(b) do
        spr(16, mybull.x, mybull.y)
        mybull.y -= 4
        if mybull.y < -8 then
            del(b, mybull)
        end
    end

    --draw ship flame
    if p.sprite == 2 then
        spr(p.flamespr, p.x - 2, p.y + 8)
        spr(p.flamespr, p.x + 2, p.y + 8)
    else
        spr(p.flamespr, p.x, p.y + 8)
    end

    --blast
    if p.blast > 0 then
        circfill(p.x + 3, p.y - 1, p.blast, 7)
    end

    --score
    for i = 1, p.lives do
        print("♥", i * 8, 8, 9)
    end

    --draw enemies
    for enemy in all(enemies) do
        spr(enemy.sprite, enemy.x, enemy.y)
    end

    --draw explosions
    for explosion in all(explosions) do
        spr(64, explosion.x - 4, explosion.y - 4, 2, 2)
        explosion.life -= 1
        if explosion.life <= 0 then
            del(explosions, explosion)
        end
    end

    --re spawn enemies
    if #enemies <= 3 then
        spawn_enemies(10)
    end

    --draw shock waves
    for mysw in all(shwaves) do
        circ(mysw.x, mysw.y, mysw.r, mysw.colr)
        mysw.r += mysw.speed
        if mysw.r >= mysw.tr then
            del(shwaves, mysw)
        end
    end

    --draw particules
    for myp in all(particules) do
        --pc=particule color
        local pc = 7
        if myp.blue then
            pc = particule_blue_age(myp.age)
        else
            pc = particule_red_age(myp.age)
        end
        --draw spark
        if myp.spark then
            pset(myp.x, myp.y, 7)
        else
            circfill(myp.x, myp.y, myp.size, pc)
        end

        --myp=my particle
        myp.x += myp.sx
        myp.y += myp.sy
        myp.sx = myp.sx * 0.85
        myp.sy = myp.sy * 0.85
        myp.age += 1

        if myp.age > myp.maxage then
            myp.size -= 0.5
            if myp.size < 0 then
                del(particules, myp)
            end
        end
    end

    --draw debug
    print("score " .. p.score, 80, 8, 10)
end