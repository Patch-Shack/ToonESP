--[[

SetupPlayers(OUTLINE COLOR;Color3.fromRGB in a table, TEXT COLOR;Color3.fromRGB in a table)

PlayerESP(Player, OUTLINE COLOR;Color3.fromRGB in a table, TEXT COLOR;Color3.fromRGB in a table)

NPCESP(NPC aka Model in Workspace btw, OUTLINE COLOR;Color3.fromRGB in a table, TEXT COLOR;Color3.fromRGB in a table, CUSTOM NAME)

PartESP(Path to Part, OUTLINE COLOR;Color3.fromRGB in a table, TEXT COLOR;Color3.fromRGB in a table, CUSTOM NAME)

ToggleESP(bool) true or false btw

ToggleTeamCheck(bool) true or false if their esp outline color/text color should be their team color

ToggleDistance(bool) true or false if the esp should show how many studs away the player/npc/part is

ToggleTeamName(bool) true or false if the esp should show the player's team name

NotifyReady() send a notification once the esp loaded, u dont have to run this tho


EXAMPLES:


local ESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/lib3.lua"))();

ESP.ToggleESP(true)

ESP.ToggleTeamCheck(true)

ESP.ToggleDistance(true)

ESP.ToggleTeamName(true)

ESP.SetupPlayers({255, 255, 255}, {255, 255, 255})

ESP.PlayerESP(Player, {255, 255, 255}, {255, 255, 255})

ESP.NPCESP(workspace.NPCs.ShopKeeper, {255, 255, 255}, {255, 255, 255}, "Seller")

ESP.PartESP(workspace.Part, {255, 255, 255}, {255, 255, 255}, "Burger")

ESP.NotifyReady()

]]--

local esplib = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local worldToViewportPoint = Camera.worldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0, 3, 0)
local espEnabled = false
local teamCheck = false
local distanceEnabled = false
local teamName = false

local function ToggleESP(bool)
	if bool == true then
		espEnabled = true
	else
		espEnabled = false
	end
end

local function ToggleTeamCheck(bool)
	if bool == true then
		teamCheck = true
	else
		teamCheck = false
	end
end

local function ToggleDistance(bool)
	if bool == true then
		distanceEnabled = true
	else
		distanceEnabled = false
	end
end

local function ToggleTeamName(bool)
	if bool == true then
		teamName = true
	else
		teamName = false
	end
end

local function NotifyReady()
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Toon ESP";
		Text = "✔";
	})
end

local function GetRoot(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	return rootPart
end

local function PlayerESP(v, colorgiven, namecolgiven)
	local OutlineColor = nil
	local NameColor = nil
	
	if colorgiven ~= nil or colorgiven ~= {} then
		OutlineColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		OutlineColor = Color3.new(0, 0, 0)
	end
	
	if namecolgiven ~= nil or namecolgiven ~= {} then
		NameColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		NameColor = Color3.new(1, 1, 1)
	end
	
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = OutlineColor
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false
	
	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = Color3.new(1, 1, 1)
	Box.Thickness = 1
	Box.Transparency = 1
	Box.Filled = false
	
	local Name = Drawing.new("Text")
	Name.Visible = false
	Name.Text = v.Name
	Name.Size = 16
	Name.Color = NameColor
	Name.Center = true
	Name.Outline = true
	
	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if v.Character ~= nil and v.Character:FindFirstChildOfClass("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= LocalPlayer and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
				if espEnabled then
					local Vector, onScreen = Camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
					
					local RootPart = v.Character.HumanoidRootPart
					local Head = v.Character.Head
					local RootPosition, RootVis = worldToViewportPoint(Camera, RootPart.Position)
					local HeadPosition = worldToViewportPoint(Camera, Head.Position + HeadOff)
					local LegPosition = worldToViewportPoint(Camera, RootPart.Position - LegOff)
					
					if onScreen then
						BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						BoxOutline.Visible = true
					
						Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						Box.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						Box.Visible = true
						
						Name.Position = Vector2.new(RootPosition.X, (RootPosition.Y + Box.Size.Y / 2) - 25)
						Name.Visible = true
					else
						BoxOutline.Visible = false
						Box.Visible = false
						Name.Visible = false
					end
					
					if teamCheck then
						if v.Team == LocalPlayer.Team then
							BoxOutline.Visible = false
							Box.Visible = false
							Name.Visible = false
						else
							BoxOutline.Color = Color3.new(v.TeamColor.r/255, v.TeamColor.g/255, v.TeamColor.b/255)
							Name.Color = Color3.new(v.TeamColor.r/255, v.TeamColor.g/255, v.TeamColor.b/255)
						end
					else
						BoxOutline.Color = OutlineColor
						Name.Color = NameColor
					end
					
					if distanceEnabled == true and teamName == false then
						local pos = math.floor((GetRoot(LocalPlayer.Character).Position - GetRoot(v.Character).Position).magnitude)
						Name.Text = v.Name .. " [" .. pos .. " Studs]"
					elseif distanceEnabled == false and teamName == true then
						Name.Text = v.Name .. " [" .. v.Team .. "]"
					elseif distanceEnabled == true and teamName == true then
						local pos = math.floor((GetRoot(LocalPlayer.Character).Position - GetRoot(v.Character).Position).magnitude)
						Name.Text = v.Name .. " [" .. v.Team .. "] " .. "[" .. pos .. " Studs]"
					else
						Name.Text = v.Name
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
					Name.Visible = false
				end
			else
				BoxOutline.Visible = false
				Box.Visible = false
				Name.Visible = false
			end
		end)
	end
	coroutine.wrap(boxesp)()
end

local function SetupPlayers(outline, text)
	for i,v in pairs(Players:GetChildren()) do
		if v ~= Players.LocalPlayer then
			PlayerESP(v, outline, text)
		end
	end
	Players.PlayerAdded:Connect(function(v)
		PlayerESP(v, outline, text)
	end)
end

local function NPCESP(v, colorgiven, namecolgiven, newname)
	local OutlineColor = nil
	local NameColor = nil
	local CustomName = nil
	
	if colorgiven ~= nil or colorgiven ~= {} then
		OutlineColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		OutlineColor = Color3.new(0, 0, 0)
	end
	
	if namecolgiven ~= nil or namecolgiven ~= {} then
		NameColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		NameColor = Color3.new(1, 1, 1)
	end
	
	if newname ~= nil or newname ~= {} then
		CustomName = newname
	else
		CustomName = v.Name
	end
	
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = OutlineColor
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false
	
	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = Color3.new(1, 1, 1)
	Box.Thickness = 1
	Box.Transparency = 1
	Box.Filled = false
	
	local Name = Drawing.new("Text")
	Name.Visible = false
	Name.Text = CustomName
	Name.Size = 16
	Name.Color = NameColor
	Name.Center = true
	Name.Outline = true
	
	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if v:FindFirstChildOfClass("Humanoid") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and v:FindFirstChildOfClass("Humanoid").Health > 0 then
				if espEnabled then
					local Vector, onScreen = Camera:worldToViewportPoint(v.HumanoidRootPart.Position)
					
					local RootPart = v.HumanoidRootPart
					local Head = v.Head
					local RootPosition, RootVis = worldToViewportPoint(Camera, RootPart.Position)
					local HeadPosition = worldToViewportPoint(Camera, Head.Position + HeadOff)
					local LegPosition = worldToViewportPoint(Camera, RootPart.Position - LegOff)
					
					if onScreen then
						BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						BoxOutline.Visible = true
					
						Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						Box.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						Box.Visible = true
						
						Name.Position = Vector2.new(RootPosition.X, (RootPosition.Y + Box.Size.Y / 2) - 25)
						Name.Visible = true
					else
						BoxOutline.Visible = false
						Box.Visible = false
						Name.Visible = false
					end
					
					if distanceEnabled then
						local pos = math.floor((GetRoot(LocalPlayer.Character).Position - GetRoot(v).Position).magnitude)
						Name.Text = CustomName .. " [" .. pos .. " Studs]"
					else
						Name.Text = CustomName
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
					Name.Visible = false
				end
			else
				BoxOutline.Visible = false
				Box.Visible = false
				Name.Visible = false
			end
		end)
	end
	coroutine.wrap(boxesp)()
end

local function PartESP(v, colorgiven, namecolgiven, newname)
	local OutlineColor = nil
	local NameColor = nil
	local CustomName = nil
	
	if colorgiven ~= nil or colorgiven ~= {} then
		OutlineColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		OutlineColor = Color3.new(0, 0, 0)
	end
	
	if namecolgiven ~= nil or namecolgiven ~= {} then
		NameColor = Color3.new(colorgiven[1]/255, colorgiven[2]/255, colorgiven[3]/255)
	else
		NameColor = Color3.new(1, 1, 1)
	end

	if newname ~= nil or newname ~= {} then
		CustomName = newname
	else
		CustomName = v.Name
	end
	
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = OutlineColor
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false
	
	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = Color3.new(1, 1, 1)
	Box.Thickness = 1
	Box.Transparency = 1
	Box.Filled = false
	
	local Name = Drawing.new("Text")
	Name.Visible = false
	Name.Text = CustomName
	Name.Size = 16
	Name.Color = NameColor
	Name.Center = true
	Name.Outline = true
	
	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if espEnabled then
				local Vector, onScreen = Camera:worldToViewportPoint(v.Position)
				
				local RootPosition, RootVis = worldToViewportPoint(Camera, v.Position)
				local HeadPosition = worldToViewportPoint(Camera, v.Position + HeadOff)
				local LegPosition = worldToViewportPoint(Camera, v.Position - LegOff)
				
				if onScreen then
					BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, RootPosition.Y - LegPosition.Y)
					BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
					BoxOutline.Visible = true
					
					Box.Size = Vector2.new(1000 / RootPosition.Z, RootPosition.Y - LegPosition.Y)
					Box.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
					Box.Visible = true
					
					Name.Position = Vector2.new(RootPosition.X, (RootPosition.Y + Box.Size.Y / 2) - 25)
					Name.Visible = true
				else
					BoxOutline.Visible = false
					Box.Visible = false
					Name.Visible = false
				end
				
				if distanceEnabled then
					local pos = math.floor((GetRoot(LocalPlayer.Character).Position - v.Position).magnitude)
					Name.Text = CustomName .. " [" .. pos .. " Studs]"
				else
					Name.Text = CustomName
				end
			else
				BoxOutline.Visible = false
				Box.Visible = false
				Name.Visible = false
			end
		end)
	end
	coroutine.wrap(boxesp)()
end

esplib.SetupPlayers = SetupPlayers
esplib.PlayerESP = PlayerESP
esplib.NPCESP = NPCESP
esplib.PartESP = PartESP
esplib.ToggleESP = ToggleESP
esplib.ToggleTeamCheck = ToggleTeamCheck
esplib.ToggleDistance = ToggleDistance
esplib.ToggleTeamName = ToggleTeamName
esplib.NotifyReady = NotifyReady

return esplib
