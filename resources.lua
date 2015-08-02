local images = {
    player = "player.png"
}

for k, v in pairs(images) do
    images[k] = love.graphics.newImage("images/"..v)
end

return {
    images = images
}
