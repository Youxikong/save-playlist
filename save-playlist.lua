--local playlist_savepath = (os.getenv('APPDATA') or os.getenv('HOME')..'/.config')..'/mpv/'
local playlist_savepath = mp.get_property('working-directory')

local utils = require("mp.utils")
local msg = require("mp.msg")

local have_menu = false

-- saves the current playlist into a m3u file
function save_playlist(savepath)
	local length = mp.get_property_number('playlist-count', 0)
	local file, err = io.open(savepath, "w")
	if not file then
		msg.error("Error in creating playlist file, check permissions and paths: " .. (err or ""))
	else
		local i = 0
		while i < length do
			local pwd = mp.get_property("working-directory")
			local filename = mp.get_property('playlist/' .. i .. '/filename')
			local fullpath = filename
			if not filename:match("^%a%a+:%/%/") then
				fullpath = utils.join_path(pwd, filename)
			end
			file:write(fullpath, "\n")
			i = i + 1
		end
		msg.info("Playlist written to: " .. savepath)
		mp.osd_message("Playlist written to: " .. savepath)
		file:close()
	end
end

-- detect menu.dll and register script message
mp.register_script_message('menu-ready', function()
	have_menu = true
	mp.register_script_message('dialog-save-reply', function(savepath)
		save_playlist(savepath)
	end)
end)

mp.register_script_message('save-playlist', function()
	local length = mp.get_property_number('playlist-count', 0)
	if length == 0 then 
		mp.osd_message("Empty Playlist")
		return 
	end

	local filename = os.time() .. "-size_" .. length .. "-playlist"

	if have_menu then
		mp.set_property_native('user-data/menu/dialog/filters', {
			{ name = 'Playlist Files',  spec = '*.m3u;*.m3u8;*.pls;*.cue' },
			{ name = 'All Files (*.*)', spec = '*.*' },
		})
		mp.set_property_native('user-data/menu/dialog/default-name', filename)
		mp.commandv('script-message-to', 'menu', 'dialog/save', mp.get_script_name())
	else
		local savepath = utils.join_path(playlist_savepath, filename .. '.m3u')
		save_playlist(savepath)
	end
end)
