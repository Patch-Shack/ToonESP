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
}

if game.PlaceId == Games["Identity Fraud"] then
  loadstr("identityfraud")
  TNotify("Identity Fraud")
else
  UniversalScript()
  TNotify("Universal")
end
