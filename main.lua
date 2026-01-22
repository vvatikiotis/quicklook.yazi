local M = {}

local get_hovered = ya.sync(function(state, b)
	local file = cx.active.current.hovered

	return file and ya.quote(tostring(file.name)), file.url
end)

local function matches_or(str, patterns)
	for pattern in patterns:gmatch("[^|]+") do
		if str:find(pattern) then
			return true
		end
	end
	return false
end

function M.entry()
	local filename, url = get_hovered()

	local video_ext = "%.mp4$|%.avi$|%.mkv$|%.mpeg$|%.mov$"
	if matches_or(filename, video_ext) then
		local osascript_cmd = [[
		      osascript -e 'tell application "Finder" to activate' -e 'tell application "Finder" to select POSIX file "]] .. url .. [["' -e 'tell application "System Events" to keystroke "y" using {command down}'
		    ]]
		ya.emit("shell", {
			osascript_cmd,
		})
	else
		ya.emit("shell", {
			"qlmanage -p " .. filename .. " 1>/dev/null",
		})
	end
end

return M
