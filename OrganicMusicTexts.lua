loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/intro.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jerka2009/Hubs/main/UI-LibraryOrganic.lua"))()
local Window = Library.CreateLib("Organic - Musics/Memes texts (For textchat)", "Synapse")

local Texts = Window:NewTab("Texts")

local MSection = Texts:NewSection("Musics")
local Music = {
	["Napoleon (Amour plastique)"] = {
		[1] = "Dans mon esprit tout divague\nJe me perds dans tes yeux",
		[2] = "Je me noie dans la vague de ton regard amoureux\nJe ne veux que ton âme divaguant sur ma peau",
		[3] = "Une fleur, une femme dans ton cœur Roméo\nJe ne suis que ton nom, le souffle lancinant",
		[4] = "De nos corps dans le sombre animés lentement\nEt la nuit je pleure des larmes qui coulent le long de mes joues",
	},
	["Нефертити"] = {
		[1] = "Я брёл однажды по пустыне\nВ трусах, с бутылкою Мартини",
		[2] = "Вокруг шикарный внешний вид\nПесок и куча пирамид",
		[3] = "И тут вдруг раз! И вот смотрите\nПеред мною Нефертити",
		[4] = "Я думал, это в мираже\nБогиня, бл#дь! И в неглиже",
		[5] = "Ну и схватил её за руку\nИ охерел, живая с#ка!",
		[6] = "Ein, zwei, fifty-fifty\nЯ, песок и Нефертити",
	},
	--[[
	["None"] = {
		[1] = "",
		[2] = "",
	},
	]]
}
--[[

]]
for key, value in pairs(Music) do
    MSection:NewButton(key, "Click to song in textchat", function()
      for k, v in pairs(value) do
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

