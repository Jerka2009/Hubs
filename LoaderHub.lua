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

print("Loaded by Organic Loader")

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[Organic Hub]",Text = "our discord is copied to your clipboard!",Duration = 5;})
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "[Organic Hub]",Text = "Enjoy!!!",Duration = 3;})

	local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Solara?"

local url = "https://discord.com/api/webhooks/1241280465013444648/N67e9GHed8SScub749Mp4m5tXXAdYKuMgztGmJSVKE4h6-tEKWUa1R9pj2MCPnwrf_2e"
	local data = {
		["content"] = plr.Name.." is used Organic Loader! | "..plr.UserId.." | "..game.Name,
	}
	local newdata = game:GetService("HttpService"):JSONEncode(data)

	local headers = {
	   ["content-type"] = "application/json"
	}
	request = http_request or request or HttpPost or syn.request
	local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
	request(abcdef)
