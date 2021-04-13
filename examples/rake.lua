local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local Misc = Lib:new("MISC")
local Players = game:GetService("Players")
local Brightness = false
local InfMana = false
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
local ESP_SupplyCrates = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
local ESP_FlareGuns = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
local ESP_Rake = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
ESP.SetupPlayers({255, 255, 255}, {255, 255, 255})
if workspace:FindFirstChild("Rake") then
	ESP_Rake.NPCESP(workspace.Rake, {232, 45, 76}, {232, 45, 76}, "Rake")
end
for i,v in pairs(workspace.SupplyCrates:GetChildren()) do
	if v.Name == "Supply Crate" then
		ESP_SupplyCrates.PartESP(v, {112, 235, 165}, {112, 235, 165}, "Supply Crate")
	end
	if v.Name == "Box" then
		if not v:FindFirstChild("fraud1") then
			ESP_SupplyCrates.PartESP(v, {112, 235, 165}, {112, 235, 165}, "Supply Crate")
		end
	end
end
for i,v in pairs(workspace:GetChildren()) do
	if v.Name == "FlareGunPickUp" then
		if not Players:FindFirstChild(v.Name) then
			ESP_FlareGuns.PartESP(v, {129, 118, 228}, {129, 118, 228}, "Flare Gun")
		end
	end
end
workspace.ChildAdded:Connect(function(Object)
	if Object.Name == "Rake" then
		ESP_Rake.NPCESP(workspace.Rake, {232, 45, 76}, {232, 45, 76}, "Rake")
	end
	if Object.Name == "FlareGunPickUp" then
		if not Players:FindFirstChild(Object.Name) then
			ESP_FlareGuns.PartESP(Object, {129, 118, 228}, {129, 118, 228}, "Flare Gun")
		end
	end
end)
workspace.SupplyCrates.ChildAdded:Connect(function(Object)
	if Object.Name == "Supply Crate" then
		ESP_SupplyCrates.PartESP(Object, {112, 235, 165}, {112, 235, 165}, "Supply Crate")
	end
	if Object.Name == "Box" then
		if not v:FindFirstChild("fraud1") then
			ESP_SupplyCrates.PartESP(Object, {112, 235, 165}, {112, 235, 165}, "Supply Crate")
		end
	end
end)
spawn(function()
	while wait() do
		if Brightness then
			game:GetService("ReplicatedStorage").CurrentLightingProperties.BRIGHTNESS.Value = 50
			game:GetService("ReplicatedStorage").CurrentLightingProperties.FOGEND.Value = 999999
		end
		if InfMana then
			Players.LocalPlayer.Character.Stamina.Value = 100
		end
	end
end)
Main:newBtn("ESP", function(bool)
	ESP.ToggleESP(bool)
end, false)
Main:newBtn("Distance", function(bool)
	ESP.ToggleDistance(bool)
	ESP_SupplyCrates.ToggleDistance(bool)
	ESP_FlareGuns.ToggleDistance(bool)
	ESP_Rake.ToggleDistance(bool)
end, false)
Misc:newBtn("Rake", function(bool)
	ESP_Rake.ToggleESP(bool)
end, false)
Misc:newBtn("Supply Crates", function(bool)
	ESP_SupplyCrates.ToggleESP(bool)
end, false)
Misc:newBtn("Flare Guns", function(bool)
	ESP_FlareGuns.ToggleESP(bool)
end, false)
Misc:newBtn("Brightness", function(bool)
	Brightness = bool
end, false)
Misc:newBtn("Infinite Stamina", function(bool)
	InfMana = bool
end, false)
Lib:SetCategory(Main)
