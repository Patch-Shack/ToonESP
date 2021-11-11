local TNotify = function(t)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Toon ESP",
		Text = tostring(t)
	})
end

local loadstr = function(url)
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/examples/" .. url .. ".lua"))();
end

local UniversalScript = function()
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Patch-Shack/ToonESP/main/universal.lua"))();
end

local Games = {
	["Identity Fraud"] = 338521019,
	["Identity Fraud 2"] = 495415914,
	["rBreach"] = 2622527242,
	["Notoriety"] = 21532277,
	["The Rake"] = 2413927524,
	["Sharkbite"] = 734159876
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
elseif game.PlaceId == Games["Sharkbite"] then
	loadstr("sharkbite")
	TNotify("Sharkbite")
else
	UniversalScript()
	TNotify("Universal")
end
