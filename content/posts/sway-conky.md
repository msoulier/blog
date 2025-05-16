+++
title = "Sway, using conky as bar"
author = ["Michael Soulier"]
date = 2025-05-16T15:35:00-04:00
lastmod = 2025-05-16T16:04:40-04:00
tags = ["linux", "sway", "wayland"]
categories = ["fun"]
draft = false
weight = 2008
+++

So while it is important to know how to use Gnome on a linux desktop, the fact is that it is not my favorite desktop environment for linux. It is far too "dumbed-down" and made mostly for the masses, and I tend to be more of a "power-user".

In the past, I became a big fan of the [I3](https://i3wm.org/) tiling window manager. It just fit the way that I work, and I found myself highly productive with it. But I3 was made to integrate with [Xorg](https://www.x.org/), and that was beginning to show its age, so the community has been working on a more modern replacement for X, being [Wayland](https://wayland.freedesktop.org/). But I3 doesn't work with Wayland! The horror!

Thankfully, some helpful devs thought of that, and wrote [Sway](https://swaywm.org/), which is basically I3 for Wayland. Yay!

So, I've been trying to figure out how to use it. Once it was set up, I wanted status along the top of the screen. I did look at the recommended [Waybar](https://github.com/Alexays/Waybar), but I didn't like it very much. I likely gave up on it too quickly, but a really simple solution turns out to be [Conky](https://github.com/brndnmtthws/conky), specifically the cli version of it. The status command will happily read from a script that updates itself every second, and conky-cli can do so easily.

```text
 $ cat conky.conf
-- vim: ft=lua:

-- Configuration settings: https://conky.cc/config_settings
conky.config = {
    lua_load = "~/.config/conky/conkylib.lua",
    cpu_avg_samples = 4,
    net_avg_samples = 2,
    update_interval = 1,
}

conky.text = [[
🌡${execi 3600 weather | grep 'Current Conditions' | awk -F: '{print $2}'} | \
⏱ $uptime | \
📈 $loadavg | \
🔧 $cpu% | \
🧮 $mem | \
🌀 $swap/$swapmax | \
💽 /: ${fs_free /} free ${fs_used /} used | \
${addr enx3448ed9dc42d} | \
▼ ${lua format %8s ${downspeed enx3448ed9dc42d}} ▲ ${lua format %8s ${upspeed enx3448ed9dc42d}} | \
⌛ ${time %A, %B %e, %Y} ${time %H:%M:%S}
]]
```

And my little lua library is pretty simple

```lua
 $ cat conkylib.lua
-- vim: ft=lua:
do
    function conky_format(fmt, input)
        local value = conky_parse(input)
        return string.format(fmt, value)
    end
end
```

From there, configure "status_command conky" in your ~/.config/sway/config file, and it just works.

{{< figure src="/ox-hugo/conky_sshot.png" alt="conky screenshot image" title="conky screenshot" >}}
