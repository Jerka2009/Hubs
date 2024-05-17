loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/intro.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/UI-LibraryOrganic.lua"))()
local Window = Library.CreateLib("Organic - Musics/Memes texts (For textchat)", "Synapse")

local Music = {
	["Napoleon"] = {
		[1] = "Dans mon esprit tout divague\nJe me perds dans tes yeux",
		[2] = "Je me noie dans la vague de ton regard amoureux\n Je ne veux que ton âme divaguant sur ma peau",
		[3] = "Une fleur, une femme dans ton cœur Roméo\n Je ne suis que ton nom, le souffle lancinant",
	},
}
local Texts = Window:NewTab("Texts")
local MSection = Texts:NewSection("Napoleon (Amour plastique)")

for key, value in pairs(Music) do
    MSection:NewButton(key, "Click to song in textchat", function()
      for k, v in pairs(value) do
		    print("Kuplet"..k)
		    local sucess, err = pcall(function()
			      local args = {[1] = v,[2] = "All"}
			      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
		    end)
		    if err then
			    local s, er = pcall(function()
				    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(v)
			    end)
		    end
        task.wait(1.1)
	    end
    end)
end

