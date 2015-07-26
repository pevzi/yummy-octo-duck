local images = {
    player = "player.png"
}

for k, v in pairs(images) do
    images[k] = love.graphics.newImage("img/"..v)
end

return {
    images = images
}
