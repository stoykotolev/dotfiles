hs.hotkey.bind({ "ctrl" }, ";", function()
	local alacritty = hs.application.find('alacritty')
	if alacritty and alacritty:isFrontmost() then
		alacritty:hide()
	else
		hs.application.launchOrFocus("/Applications/Alacritty.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "'", function()
	local inkdrop = hs.application.find("inkdrop")
	if inkdrop and inkdrop:isFrontmost() then
		inkdrop:hide()
	else
		hs.application.launchOrFocus("/Applications/Inkdrop.app")
	end
end)

hs.hotkey.bind({ "option" }, "t", function()
	local teams = hs.application.find("teams")
	if teams and teams:isFrontmost() then
		teams:hide()
	else
		hs.application.launchOrFocus("/Applications/Microsoft Teams.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "]", function()
	local slack = hs.application.find('slack')
	if slack and slack:isFrontmost() then
		slack:hide()
	else
		hs.application.launchOrFocus("/Applications/Slack.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "[", function()
	local discord = hs.application.find('discord')
	if discord and discord:isFrontmost() then
		discord:hide()
	else
		hs.application.launchOrFocus("/Applications/Discord.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "b", function()
	local arc = hs.application.find('arc')
	if arc and arc:isFrontmost() then
		arc:hide()
	else
		hs.application.launchOrFocus("/Applications/Arc.app")
	end
end)

hs.hotkey.bind({ "option" }, "r", function()
	local rider = hs.application.find("rider")
	if rider and rider:isFrontmost() then
		rider:hide()
	else
		hs.application.launchOrFocus("/Applications/Rider.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "s", function()
	local spotify = hs.application.find('spotify')
	if spotify and spotify:isFrontmost() then
		spotify:hide()
	else
		hs.application.launchOrFocus("/Applications/Spotify.app")
	end
end)
