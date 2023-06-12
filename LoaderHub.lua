--[[
                               /$$                  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$ 
                              | $$                 /$$__  $$ /$$$_  $$ /$$$_  $$ /$$__  $$
       /$$  /$$$$$$   /$$$$$$ | $$   /$$  /$$$$$$ |__/  \ $$| $$$$\ $$| $$$$\ $$| $$  \ $$
      |__/ /$$__  $$ /$$__  $$| $$  /$$/ |____  $$  /$$$$$$/| $$ $$ $$| $$ $$ $$|  $$$$$$$
       /$$| $$$$$$$$| $$  \__/| $$$$$$/   /$$$$$$$ /$$____/ | $$\ $$$$| $$\ $$$$ \____  $$
      | $$| $$_____/| $$      | $$_  $$  /$$__  $$| $$      | $$ \ $$$| $$ \ $$$ /$$  \ $$
      | $$|  $$$$$$$| $$      | $$ \  $$|  $$$$$$$| $$$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/
      | $$ \_______/|__/      |__/  \__/ \_______/|________/ \______/  \______/  \______/ 
 /$$  | $$                                                                                
|  $$$$$$/                                                                                
 \______/                                                                                 

]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/intro.lua"))()
local selectid = false
local games = {
    [{9848789324}] = "https://raw.githubusercontent.com/i4mitty/InfernoHub/main/InfernoHub.lua",
    [{606849621}] = "https://raw.githubusercontent.com/vova999000333/Hubs/main/OriganeJailbreak.lua",
    [{1224212277}] = "https://raw.githubusercontent.com/vova999000333/Hubs/main/OriganeMadCity.lua",
    [{621129760}] = "https://raw.githubusercontent.com/vova999000333/Hubs/main/KATLoader.lua",
    [{142823291}] = "https://raw.githubusercontent.com/Ethanoj1/EclipseMM2/master/Script",
    [{155615604}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Prison%20Life/Script.lua",
    [{7041939546}] = "https://raw.githubusercontent.com/vova999000333/Hubs/main/OriganeHub.lua",
    [{6839171747}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Doors/Loader.lua",
}

for ids, url in next, games do
    if table.find(ids, game.PlaceId) then
        loadstring(game:HttpGet(url))()
        selectid = true
        break
    end
end
if not selectid then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vova999000333/Hubs/main/OriganeHub.lua"))()
end

print("Loaded by OrganicLoader")
