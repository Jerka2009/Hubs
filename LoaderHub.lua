local games = {
    [{606849621}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Jailbreak/Script.lua",
    [{8982709021}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/YouTube%20Life/Auto%20Farm.lua",
    [{537413528}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Build%20A%20Boat%20For%20Treasure/Script.lua",
    [{3101667897}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Legends%20Of%20Speed/Script.lua",
    [{3956818381}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Ninja%20Legends/Script.lua",
    [{4623386862, 5661005779}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Piggy/Loader.lua",
    [{155615604}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Prison%20Life/Script.lua",
    [{1962086868, 3582763398}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Tower%20of%20Hell/Script.lua",
    [{6839171747}] = "https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Doors/Loader.lua",
}

for ids, url in next, games do
    if table.find(ids, game.PlaceId) then
        loadstring(game:HttpGet(url))()
        break
    end
end
