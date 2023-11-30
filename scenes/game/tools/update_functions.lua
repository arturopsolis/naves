--game update functions

function player_controls()
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
end

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

function spawn_enemies(type, enx, eny, enemy_wait)
    local new_enemy = {
        x = enx * 1.2 - 16,
        y = eny - 66,
        posy = eny,
        posx = enx,
        h = 8,
        w = 8,
        tile_w = 1,
        tile_h = 1,
        frameIndex = 1,
        type = type,
        mission = "flying",
        wait = enemy_wait,
        speed_x = 2,
        speed_y = 2,
        animationSpeed = 0.4
    }

    if type == nil or type == 1 then
        new_enemy.sprites = { 36, 37, 38, 39 }
        new_enemy.live = 1
        new_enemy.speed_x = 1.7
        new_enemy.speed_y = 1
    elseif type == 2 then
        new_enemy.sprites = { 76, 77, 78, 79 }
        new_enemy.live = 2
        new_enemy.speed_x = 1.7
        new_enemy.speed_y = 1.2
    elseif type == 3 then
        new_enemy.sprites = { 88, 89, 90, 91 }
        new_enemy.live = 2
        new_enemy.speed_x = 0
        new_enemy.speed_y = 1
    elseif type == 4 then
        new_enemy.sprites = { 72, 73, 74, 75 }
        new_enemy.live = 16
        new_enemy.speed_x = 0
        new_enemy.speed_y = 1
    end

    add(enemies, new_enemy)
end

function update_enemies()
    for enemy in all(enemies) do
        --enemy mission
        doEnemy(enemy) --TODO: change function name

        -- animation
        if enemy.frameIndex >= #enemy.sprites then
            enemy.frameIndex = 1
            enemy.sprite = enemy.sprites[enemy.frameIndex]
        else
            enemy.frameIndex += enemy.animationSpeed
        end

        --delete enemy
        if enemy.mission != "flying" then
            if enemy.y > 128 or enemy.x < -8 or enemy.x > 128 then
                del(enemies, enemy)
            end
        end

        if p.invul <= 0 then
            if collide(p, enemy) then
                explode(p.x + 4, p.y + 4, true)
                p.lives -= 1
                p.invul = 300
                enemy.live -= 1
                sfx(1)
                if p.lives <= 0 then
                    change_to_scene("gameover")
                end
            end
        end
        p.invul -= 1
    end
end

--enemy mission
function doEnemy(enemy)
    if enemy.wait > 0 then
        enemy.wait -= 1
        return
    end

    if enemy.mission == "flying" then
        --flying
        --basic easing function
        -- x += (targetx - x)/n
        enemy.x += (enemy.posx - enemy.x) / 7
        enemy.y += (enemy.posy - enemy.y) / 7

        if abs(enemy.y - enemy.posy) < 0.7 then
            enemy.y = enemy.posy
            enemy.mission = "protect"
        end
    elseif enemy.mission == "protect" then
        --protect
        --enemy.y += 10
    elseif enemy.mission == "attack" then
        --atack!
        --set sy

        if enemy.type == 1 then
            enemy.speed_y = 1.7
            enemy.speed_x = sin(t / 45)

            if enemy.x < 32 then
                enemy.speed_x += 1 - enemy.x / 32
            end
            if enemy.x > 88 then
                enemy.speed_x -= (enemy.x - 88) / 32
            end
        end

        if enemy.type == 2 then
            enemy.speed_y = 2.5
            enemy.speed_x = sin(t / 20)

            if enemy.x < 32 then
                enemy.speed_x += 1 - enemy.x / 32
            end
            if enemy.x > 88 then
                enemy.speed_x -= (enemy.x - 88) / 32
            end
        end

        if enemy.type == 3 then
            if enemy.speed_x == 0 then
                --flying down
                enemy.speed_y = 2
                if p.y <= enemy.y then
                    enemy.speed_y = 0
                    if p.x < enemy.x then
                        enemy.speed_x = -2
                    else
                        enemy.speed_x = 2
                    end
                end
            end
        end
        if enemy.type == 4 then
            enemy.speed_x = 0
            enemy.speed_y = 0.35
        end

        move(enemy)
    end
end

function move(obj)
    obj.x += obj.speed_x
    obj.y += obj.speed_y
end

function picking()
    if scene != "game" then
        return
    end

    if t % 60 == 0 and #enemies > 0 then
        local enemy = rnd(enemies)
        if enemy.mission == "protect" then
            enemy.mission = "attack"
        end
    end
end

function animate_flame()
    p.flamespr = p.flamespr + .7
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

function collision_enemies_bullets()
    for enemy in all(enemies) do
        for bullet in all(b) do
            if collide(enemy, bullet) then
                del(b, bullet)
                small_shwave(bullet.x, bullet.y)
                small_spark(bullet.x, bullet.y)
                enemy.y -= 2
                if enemy.live <= 0 then
                    del(enemies, enemy)
                    sfx(3)
                    explode(enemy.x + 4, enemy.y + 4, false)
                    p.score += 100
                end
                enemy.sprite = 56 --TODO: change to dynamic sprite
                enemy.live -= 1
                sfx(2)
                if #enemies <= 0 then
                    nextWave()
                end
                break
            end
        end
    end
end

function small_shwave(x, y)
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

function small_spark(x, y)
    local myp = {}
    myp.x = x
    myp.y = y

    myp.sx = (rnd() - 0.5) * 8
    myp.sy = (rnd() - 1) * 3

    myp.age = rnd(2)
    myp.size = 1 + rnd(4)
    myp.maxage = 10 + rnd(10)
    myp.spark = true

    add(particules, myp)
end

function animate_stars()
    for i = 1, #stars do
        local star = stars[i]
        star.y = star.y + star.speed + starExtraSpeed
        if star.y > 128 then
            star.y = star.y - 128
        end
    end
end

--other tools

function collide(a, b)
    local a_left = a.x
    local a_top = a.y
    local a_right = a.x + a.w - 1
    local a_bottom = a.y + a.h - 1

    local b_left = b.x
    local b_top = b.y
    local b_right = b.x + b.h - 1
    local b_bottom = b.y + b.w - 1

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