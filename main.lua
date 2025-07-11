local get_hovered = ya.sync(function(state, b)
	local h = cx.active.current.hovered

	return h and ya.quote(tostring(h.name)), h.url
end)

local function matches_or(str, patterns)
	for pattern in patterns:gmatch("[^|]+") do
		if str:find(pattern) then
			return true
		end
	end
	return false
end

return {
	entry = function(state, args)
		local extensions = "%.mp4$|%.avi$|%.mkv$|%.mpeg$|%.mov$"

		local filename, url = get_hovered()
		if matches_or(filename, extensions) then
			local osascript_cmd = [[
		      osascript -e 'tell application "Finder" to activate' -e 'tell application "Finder" to select POSIX file "]] .. url .. [["' -e 'tell application "System Events" to keystroke "y" using {command down}'
		    ]]
			ya.manager_emit("shell", {
				osascript_cmd,
				block = false,
				orphan = true,
				confirm = true,
			})
		else
			ya.manager_emit("shell", {
				"qlmanage -p " .. filename .. " 1>/dev/null",
				block = false,
				orphan = true,
				confirm = true,
			})
		end
	end,
}
