# save-playlist
This script saves your current playlist to the working directory of the mpv process and works well along with [autoload.lua](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua).

Disclaimer: This is not my script. I took it from a [Reddit thread](https://old.reddit.com/r/mpv/comments/ax925a/playlist_how_to_save_currently_internal_playlist/emhpie3/?context=3) and added it here since I couldnt find a script that saves the playlist and works with [autoload.lua](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua).

Thanks to [@Goroto](https://github.com/garoto) (the deleted one) and [@jonniek](https://github.com/jonniek) (his muse) for the script! All credits go to both of them. Without their help, this wouldn't have existed. Thank you again!

Now it support [mpv-menu-dll](https://github.com/tsl0922/mpv-menu-plugin)

# Installation
Place this script inside your `/scripts` folder.

# How to use the script?
To activate the script press `Alt + s`. 

The keybinds for this script can be changed by placing the following lines in your ``input.conf``:  
```
KEY script-binding save-playlist
```
