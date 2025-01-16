hs.hotkey.bind({ "ctrl" }, ";", function()
	local alacritty = hs.application.find('alacritty')
	if alacritty:isFrontmost() then
		alacritty:hide()
	else
		hs.application.launchOrFocus("/Applications/Alacritty.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "'", function()
	local inkdrop = hs.application.find("inkdrop")
	if inkdrop:isFrontmost() then
		inkdrop:hide()
	else
		hs.application.launchOrFocus("/Applications/Inkdrop.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "]", function()
	local alacritty = hs.application.find('slack')
	if alacritty:isFrontmost() then
		alacritty:hide()
	else
		hs.application.launchOrFocus("/Applications/Slack.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "[", function()
	local alacritty = hs.application.find('discord')
	if alacritty:isFrontmost() then
		alacritty:hide()
	else
		hs.application.launchOrFocus("/Applications/Discord.app")
	end
end)

hs.hotkey.bind({ "ctrl" }, "b", function()
	local alacritty = hs.application.find('arc')
	if alacritty:isFrontmost() then
		alacritty:hide()
	else
		hs.application.launchOrFocus("/Applications/Arc.app")
	end
end)
