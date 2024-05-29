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
if _G.OrganicLoaded then
  game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[Organic Hub]",Text = "Hub is already loaded!",Duration = 4;})
  return
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/intro.lua"))()
local selectid = false
local plr = game:GetService("Players").LocalPlayer
local admin = {4989772447}
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
    [{189707}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/NaturalDisasterOrganic.lua",
    [{13924946576}] = "https://raw.githubusercontent.com/Jerka2009/Hubs/main/DingusReservHub.lua",
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

_G.OrganicLoaded = true

print("Loaded by Organic Loader")

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[Organic Hub]",Text = "our discord is copied to your clipboard!",Duration = 5;})
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[Organic Hub]",Text = "Enjoy!!!",Duration = 3;})

if not table.find(admin, plr.UserId) then
    local url = "https://discord.com/api/webhooks/1241280465013444648/N67e9GHed8SScub749Mp4m5tXXAdYKuMgztGmJSVKE4h6-tEKWUa1R9pj2MCPnwrf_2e"
    local data = {
        ["embeds"] = {{
            ["title"] = "Player "..plr.Name.."",
            ["description"] = "ID: "..plr.UserId.."\nGame: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
        }}
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
    print("Username & UserId has been sended to owner.")
end
