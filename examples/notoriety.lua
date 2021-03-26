local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/UiLib.lua"))();
local Main = Lib:new("MAIN")
local Aimbot = false
local Aiming = false
local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();
for i,v in pairs(workspace.Police:GetChildren()) do
	ESP.NPCESP(v, {73, 78, 228}, {73, 78, 228}, "Cop")
end
workspace.Police.ChildAdded:Connect(function(v)
	ESP.NPCESP(v, {73, 78, 228}, {73, 78, 228}, "Cop")
end)
local function ClosetCop()
	local dist = math.huge
	local target = nil
	if v.Character and v.Character:FindFirstChild("Torso") and Aimbot and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
		local magnitude = (v.Character.Torso.Position - Players.LocalPlayer.Character.Torso.Position).magnitude
		if magnitude < dist then
			dist = magnitude
			target = v
		end
	end
end
Main:newBtn("Police ESP", function(bool)
	ESP.ToggleESP(bool)
end, false)
Main:newBtn("Distance", function(bool)
	ESP.ToggleDistance(bool)
end, false)
Main:newBtn("Aimbot", function(bool)
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
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosetCop().Character.Torso.Position)
	end
end)
Lib:SetCategory(Main)
