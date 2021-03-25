--[[
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib.lua"))();
local Players = game:GetService("Players")

for i,v in pairs(Players:GetChildren()) do
	if v ~= Players.LocalPlayer then
		ESP.PlayerESP(v, {112, 235, 165}, {112, 235, 165})
	end
end

for _, a in pairs(workspace.NPCs:GetChildren()) do
	ESP.NPCESP(a, {232, 45, 76}, {232, 45, 76}, a.Name)
end

for i,v in pairs(workspace["Doors"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 1")
	end
end

for i,v in pairs(workspace["Second Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 2")
	end
end

for i,v in pairs(workspace["Third Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 3")
	end
end

for i,v in pairs(workspace["Finale Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Finale Door")
	end
end

workspace.NPCs.ChildAdded:Connect(function(mob)
	ESP.NCPESP(mob, {232, 45, 76}, {232, 45, 76}, mob.Name)
end)

Players.PlayerAdded:Connect(function(v)
	ESP.PlayerESP(v, {112, 235, 165}, {112, 235, 165})
end)

ESP.NotifyReady()
]]--
local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
ESP.SetupPlayers({255, 255, 255}, {255, 255, 255})
for _, a in pairs(workspace.NPCs:GetChildren()) do
	ESP.NPCESP(a, {232, 45, 76}, {232, 45, 76}, a.Name)
end
for i,v in pairs(workspace["Doors"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 1")
	end
end
for i,v in pairs(workspace["Second Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 2")
	end
end
for i,v in pairs(workspace["Third Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Door 3")
	end
end
for i,v in pairs(workspace["Finale Door"]:GetChildren()) do
	if v:IsA("Part") then
		ESP.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Finale Door")
	end
end
workspace.NPCs.ChildAdded:Connect(function(mob)
	ESP.NCPESP(mob, {232, 45, 76}, {232, 45, 76}, mob.Name)
end)
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
