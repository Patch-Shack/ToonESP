local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib2.lua"))();
ESP.SetupPlayers({255, 255, 255}, {255, 255, 255})
Main:newBtn("ESP", function(bool)
	ToggleESP(bool)
end, false)
Main:newBtn("Team Check", function(bool)
	ToggleTeamCheck(bool)
end, false)
Lib:SetCategory(Main)
