local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Organic - Murderers VS Sheriffs Duels", "Synapse")
    
     -- MAIN
    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
  local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
local Other = Window:NewTab("Other")
    local OtherSection = Other:NewSection("Other")
    local Esp = Window:NewTab("Esp")
    local EspSection = Other:NewSection("Esp")


    MainSection:NewButton("Hitbox Expander", "Expanded + Visual hitbox", function()
        loadstring(game:HttpGet('https://pastebin.com/raw/zr5xBZKr'))()
    end)

    OtherSection:NewToggle("Obviously Hacking Mode", "Makes You Jump High And Walk Fast", function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 200
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end)

    OtherSection:NewButton("Infinite Yield", "FE Admin Commands", function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    end)

    EspSection:NewButton("Chams", "See A Person Behind A Wall", function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/QH47i0JP'),true))()
    end)

    --LOCAL PLAYE

    PlayerSection:NewSlider("Walkspeed Changer", "Change If You Want To", 500, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

    PlayerSection:NewSlider("Jumppower Changer", "Change If You Want Prob Doesnt Work", 350, 50, function(s)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
    end)

    PlayerSection:NewButton("Reset WS/JP", "Resets to all defaults", function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)

    OtherSection:NewButton("Chat Spoofer", "Lets you chat for other people", function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/djBfk8Li'),true))()
    end)

    OtherSection:NewButton("Bypassed Fly", "Literally fly in any game", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nicuse/RobloxScripts/main/BypassedFly.lua"))() 

        Fly(true)
    end)

     -- Esp

    EspSection:NewButton("Esp", "Player Info / see player through walls", function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/nqyGkWvx'),true))()
    end)
