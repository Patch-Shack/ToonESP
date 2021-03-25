local function TNotify(t)
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Toon ESP";
		Text = t;
	})
end

local function loadstr(url)
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/examples/" .. url .. ".lua"))();
end

local function UniversalScript()
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/universal.lua"))();
end

local Games = {
	["Identity Fraud"] = 338521019,
	["Identity Fraud 2"] = 495415914,
}

if game.PlaceId == Games["Identity Fraud"] then
	loadstr("identityfraud")
	TNotify("Identity Fraud")
elseif game.PlaceId == Games["Identity Fraud 2"] then
	loadstr("identityfraud2")
	TNotify("Identity Fraud 2")
else
	UniversalScript()
	TNotify("Universal")
end
