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
loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/intro.lua"))()
local selectid = false
local plr = game:GetService("Players").LocalPlayer
local games = {
  --- Ragdolls
    [{9848789324}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicRagdoll.lua",
    [{5683833663}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicRagdoll.lua",
    [{5950733731}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicRagdoll.lua",
    [{6584731191}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicRagdoll.lua",
    [{15162407879}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicRagdoll.lua",
  --- Other games
    [{606849621}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OriganeJailbreak.lua",
    [{1224212277}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OriganeMadCity.lua",
    [{12355337193}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/MurderVSsheriff.lua",
    [{6142500718}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/GetMusicId.lua",
    [{13771457545}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/MurderVSsheriff.lua",
    [{621129760}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/KATLoader.lua",
    [{142823291}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OrganicMM2.lua",
    [{155615604}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Prison%20Life/Script.lua",
    [{7041939546}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/OriganeHub.lua",
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
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/OriganeHub.lua"))()
end

print("Loaded by Organic Loader")
