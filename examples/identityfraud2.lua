local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
ESP.SetupPlayers({112, 235, 165}, {112, 235, 165})
for i,v in pairs(workspace:GetChildren()) do
  if (v.Name == "Stan") and v:FindFirstChild("Ai") then
    ESP.NPCESP(v, {232, 45, 76}, {232, 45, 76}, "Stan")
  end
end
Main:newBtn("ESP", function(bool)
	ESP.ToggleESP(bool)
end, false)
Main:newBtn("Team Check", function(bool)
	ESP.ToggleTeamCheck(bool)
end, false)
Main:newBtn("Team Name", function(bool)
	ESP.ToggleTeamName(bool)
end, false)
Main:newBtn("Distance", function(bool)
	ESP.ToggleDistance(bool)
end, false)
Lib:SetCategory(Main)
