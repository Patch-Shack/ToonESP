local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local Misc = Lib:new("MISC")
local Combat = Lib:new("COMBAT")
local Aimbot = false
local Aiming = false
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
local ESP2 = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
local ESP3 = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
ESP.SetupPlayers({255, 255, 255}, {255, 255, 255})
local function ClosetPlayer()
	local dist = math.huge
	local target = nil
	for i,v in pairs (Players:GetPlayers()) do
		if v ~= Players.LocalPlayer then
			if v.Character and v.Character:FindFirstChild("Head") and v.TeamColor ~= Players.LocalPlayer.TeamColor and Aimbot and v.Character.Humanoid.Health > 0 then
				local magnitude = (v.Character.Head.Position - Players.LocalPlayer.Character.Head.Position).magnitude
				if magnitude < dist then
					dist = magnitude
					target = v
				end
			end
		end
	end
	return target
end
for i,v in pairs(workspace.FunctionalDoors.Door:GetChildren()) do
	if v.Name == "Elevator" then
		ESP2.PartESP(v, {213, 70, 235}, {213, 70, 235}, "Elevator")
	end
end
for i,v in pairs(workspace.Map["Gate A"]:GetChildren()) do
	if v:IsA("Part") or v:IsA("BasePart") then
		ESP3.PartESP(v, {197, 109, 210}, {197, 109, 210}, "Gate A")
	end
end
for i,v in pairs(workspace.Map["Gate B"]:GetChildren()) do
	if v:IsA("Part") or v:IsA("BasePart") then
		ESP3.PartESP(v, {197, 109, 210}, {197, 109, 210}, "Gate B")
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
Misc:newBtn("Gates", function(bool)
	ESP3.ToggleESP(bool)
end, false)
Misc:newBtn("Elevators", function(bool)
	ESP2.ToggleESP(bool)
end, false)
Misc:newBtn("Distance", function(bool)
	ESP2.ToggleDistance(bool)
	ESP3.ToggleDistance(bool)
end, false)
Combat:newBtn("Aimbot", function(bool)
	Aimbot = bool
end, false)
UIS.InputBegan:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton2 then
		if Aimbot then
			Aiming = true
		end
	end
end)
UIS.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton2 then
		Aiming = false
	end
end)
game:GetService("RunService").RenderStepped:Connect(function()
	if Aiming then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosetPlayer().Character.Head.Position)
	end
end)
Lib:SetCategory(Main)
