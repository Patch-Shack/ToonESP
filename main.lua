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
	["rBreach"] = 2622527242,
	["Notoriety"] = 21532277,
	["The Rake"] = 2413927524,
}

if game.PlaceId == Games["Identity Fraud"] then
	loadstr("identityfraud")
	TNotify("Identity Fraud")
elseif game.PlaceId == Games["Identity Fraud 2"] then
	loadstr("identityfraud2")
	TNotify("Identity Fraud 2")
elseif game.PlaceId == Games["rBreach"] then
	loadstr("rbreach")
	TNotify("rBreach")
elseif game.PlaceId == Games["Notoriety"] then
	loadstr("notoriety")
	TNotify("Notoriety")
elseif game.PlaceId == Games["The Rake"] then
	loadstr("rake")
	TNotify("The Rake")
else
	UniversalScript()
	TNotify("Universal")
end
