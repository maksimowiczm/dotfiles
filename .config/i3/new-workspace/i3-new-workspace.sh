#!/bin/bash
# https://github.com/mivort/i3-new-workspace#MIT-1-ov-file
# 
# The MIT License (MIT)
# 
# Copyright (c) 2016 lufterc
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Enable strict mode
set -euo pipefail

function show_help {
    echo "USAGE:"
    echo "    i3-new-workspace [OPTIONS]"
    echo
    echo "OPTIONS:"
    echo "    -m, --move   Move current container to the new workspace"
    echo "    -c, --carry  Carry (move and focus) current container to the new workspace"
    echo "    -h, --help   Print help information"
}

# Use swaymsg if WAYLAND_DISPLAY is set
msg_cmd=${WAYLAND_DISPLAY+swaymsg}
msg_cmd=${msg_cmd:-i3-msg}

# Set options
opt_mode=new

# Process CLI arguments
while [ $# -gt 0 ] ; do
    case $1 in
        "--move"|"-m") opt_mode=move ;;
        "--carry"|"-c") opt_mode=carry ;;
        "--help"|"-h"|"-?") show_help ; exit 0 ;;
        *) show_help ; exit 1 ;;
    esac
    shift
done

ws_json=$($msg_cmd -t get_workspaces)
for i in {1..10} ; do
    [[ $ws_json =~ \"num\":\ ?$i ]] && continue

    case $opt_mode in
        "new") $msg_cmd workspace number "$i" ;;
        "move") $msg_cmd move container to workspace number "$i" ;;
        "carry") $msg_cmd move container to workspace number "$i", workspace number "$i" ;;
    esac
    break
done
