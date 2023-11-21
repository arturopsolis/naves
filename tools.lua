function change_scene(new_scene)
    scene = new_scene
    scenes[scene].init()
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

function draw_stars()
    for i = 1, #stars do
        pset(
            stars[i].x,
            stars[i].y,
            stars[i].colr
        )
    end
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

function smol_shwave(x, y)
    local mysw = {}
    mysw.x = x
    mysw.y = y
    mysw.r = 3
    mysw.tr =
        --target
        6
    mysw.colr = 9
    mysw.speed = 1
    add(shwaves, mysw)
end

function big_shwave(x, y)
    local mysw = {}
    mysw.x = x
    mysw.y = y
    mysw.r = 3
    mysw.tr =
        --target
        25
    mysw.colr = 7
    mysw.speed = 3.5
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