function draw_player()
    if p.invulnerability <= 0 then
        draw_ship()
        draw_ship_flame()
    else
        if sin(t / 5) < 0 then
            draw_ship()
            draw_ship_flame()
        end
    end
end

function draw_ship()
    spr(p.sprite, p.x, p.y)
end

function draw_ship_flame()
    if p.sprite == 2 then
        spr(p.flames_sprite, p.x - 2, p.y + 8)
        spr(p.flames_sprite, p.x + 2, p.y + 8)
    else
        spr(p.flames_sprite, p.x, p.y + 8)
    end
end

function draw_blast()
    if p.blast > 0 then
        circfill(p.x + 3, p.y - 1, p.blast, 7)
        circfill(p.x + 4, p.y - 1, p.blast, 7)
    end
end

function draw_bullets()
    for mybull in all(bullets) do
        spr(16, mybull.x, mybull.y)
        mybull.y -= 4
        if mybull.y < -8 then
            del(bullets, mybull)
        end
    end
end

--draw enemies

function draw_enemies()
    for enemy in all(enemies) do
        if enemy.flash > 0 then
            enemy.flash -= 1
            for i = 1, 15 do
                pal(i, 7)
            end
        end
        spr(enemy.sprites[flr(enemy.frameIndex)], enemy.x, enemy.y, enemy.tile_h, enemy.tile_w)
        pal()
    end
end

--draw special effects

function draw_particules()
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
end

function draw_shock_waves()
    for mysw in all(shwaves) do
        circ(mysw.x, mysw.y, mysw.r, mysw.colr)
        mysw.r += mysw.speed
        if mysw.r >= mysw.tr then
            del(shwaves, mysw)
        end
    end
end

function draw_explosions()
    for explosion in all(explosions) do
        spr(64, explosion.x - 4, explosion.y - 4, 2, 2)
        explosion.life -= 1
        if explosion.life <= 0 then
            del(explosions, explosion)
        end
    end
end

--draw background
function draw_stars()
    for i = 1, #stars do
        pset(
            stars[i].x,
            stars[i].y,
            stars[i].colr
        )
    end
end

--draw ui
function draw_score()
    for i = 1, p.lives do
        print("♥", i * 8, 4, 8)
    end
    print(p.score, 100, 4, 10)
end

function draw_debug()
    --print(p.invulnerability, 100, 24, 10)
end