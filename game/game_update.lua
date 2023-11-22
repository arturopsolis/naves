--game update functions

function particule_red_age(age)
    local colr = 7
    if age > 5 then
        colr = 10
    end
    if age > 7 then
        colr = 9
    end
    if age > 10 then
        colr = 8
    end
    if age > 12 then
        colr = 2
    end
    if age > 15 then
        colr = 5
    end
    return colr
end

function particule_blue_age(age)
    local colr = 7
    if age > 5 then
        colr = 6
    end
    if age > 7 then
        colr = 12
    end
    if age > 10 then
        colr = 13
    end
    if age > 12 then
        colr = 1
    end
    if age > 15 then
        colr = 1
    end
    return colr
end

function explode(x, y, isblue)
    local speed =
        --particle speed
        6
    local myp = {}
    myp.x = x
    myp.y = y

    myp.sx = 0
    myp.sy = 0

    myp.age = 0
    myp.size = 8
    myp.maxage = 0
    myp.blue = isblue
    myp.spark = true

    add(particules, myp)

    for i = 1, 30 do
        local speed =
            --particle speed
            6
        local myp = {}
        myp.x = x
        myp.y = y

        myp.sx = (rnd() - 0.5) * speed
        myp.sy = (rnd() - 0.5) * speed

        myp.age = rnd(2)
        myp.size = 1 + rnd(4)
        myp.maxage = 10 + rnd(10)
        myp.blue = isblue

        add(particules, myp)
    end
    for i = 1, 20 do
        local speed =
            --particle speed
            10
        local myp = {}
        myp.x = x
        myp.y = y

        myp.sx = (rnd() - 0.5) * speed
        myp.sy = (rnd() - 0.5) * speed

        myp.age = rnd(2)
        myp.size = 1 + rnd(4)
        myp.maxage = 10 + rnd(10)
        myp.blue = isblue
        myp.spark = true

        add(particules, myp)
    end
    big_shwave(x, y)
end

function spawn_enemies(num)
    for i = 1, num do
        local enemy = {
            x = rnd(128),
            y = rnd(60) - 80,
            h = 8,
            w = 8,
            sprite = 36,
            anim = { 36, 37, 38, 39 },
            live = 2
        }
        add(enemies, enemy)
    end
end

function update_spawn_enemies()
    if #enemies <= 3 then
        spawn_enemies(5)
    end
end

function animate_flame()
    p.flamespr += 1
    if p.flamespr >= 9 then
        p.flamespr = 5
    end
end

function animate_blast()
    if p.blast > 0 then
        p.blast = p.blast - 1
    end
end

function hiting_border()
    p.x = mid(0, p.x, 120)
    p.y = mid(0, p.y, 127 - 16)
end

function update_enemies()
    for enemy in all(enemies) do
        if enemy.y <= 128 then
            enemy.y += 1
        else
            enemy.y = -8
            enemy.x = rnd(128)
        end
        if enemy.sprite >= 55 then
            enemy.sprite = 52
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
                    change_to_scene("gameover")
                end
            end
        end
        p.invul -= 1
    end
end

function collision_enemies_bullets()
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
                enemy.sprite = 56
                enemy.live -= 1
                sfx(2)
                break
            end
        end
    end
end

function smol_shwave(x, y)
    local mysw = {}
    mysw.x = x
    mysw.y = y
    mysw.r = 3
    mysw.tr = 6
    mysw.colr = 9
    mysw.speed = 1
    add(shwaves, mysw)
end

function big_shwave(x, y)
    local mysw = {
        x = x,
        y = y,
        r = 3,
        tr = 25,
        colr = 7,
        speed = 3.5
    }

    add(shwaves, mysw)
end

function smol_spark(x, y)
    local myp = {}
    myp.x = x
    myp.y = y

    myp.sx = (rnd() - 0.5) * 8
    myp.sy = (rnd() - 1) * 3

    myp.age = rnd(2)
    myp.size = 1 + rnd(4)
    myp.maxage = 10 + rnd(10)
    myp.blue = isblue
    myp.spark = true

    add(particules, myp)
end

function animate_stars()
    for i = 1, #stars do
        local star = stars[i]
        star.y = star.y + star.speed
        if star.y > 128 then
            star.y = star.y - 128
        end
    end
end

--other tools

function collide(a, b)
    local a_left = a.x
    local a_top = a.y
    local a_right = a.x + 7
    local a_bottom = a.y + 7

    local b_left = b.x
    local b_top = b.y
    local b_right = b.x + 7
    local b_bottom = b.y + 7

    if a_top > b_bottom then return false end
    if b_top > a_bottom then return false end
    if a_left > b_right then return false end
    if b_left > a_right then return false end

    return true
end

function change_to_scene(new_scene)
    scene = new_scene
    scenes[scene].init()
end

function generate_stars()
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

function bullet_timer()
    p.bullet_timer -= 1
end