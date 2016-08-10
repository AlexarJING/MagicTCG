texture={}
local dir = "cards"
local files = love.filesystem.getDirectoryItems( dir )
for k, file in ipairs(files) do
    local dot=string.find(file, "%.")
    local name=string.sub(file,1,dot-1)
    local exp=string.sub(file,dot+1)
    if exp=="jpg" or exp=="JPG" or exp=="tga" or exp=="TGA" then
        texture[name] = love.graphics.newImage(dir.."/"..file)
    end
end
local dir = "faces"
local files = love.filesystem.getDirectoryItems( dir )
for k, file in ipairs(files) do
    local dot=string.find(file, "%.")
    local name=string.sub(file,1,dot-1)
    local exp=string.sub(file,dot+1)
    if exp=="jpg" or exp=="JPG" or exp=="tga" or exp=="TGA" or exp=="png" then
        texture[name] = love.graphics.newImage(dir.."/"..file)
    end
end