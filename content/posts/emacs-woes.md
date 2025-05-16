+++
title = "Emacs woes"
author = ["Michael Soulier"]
date = 2025-03-31T08:07:00-04:00
publishDate = 2025-03-22T00:00:00-04:00
lastmod = 2025-05-16T09:37:44-04:00
tags = ["emacs"]
draft = false
weight = 2007
+++

So I recently got back into using [Emacs](https://www.gnu.org/software/emacs/), primarily as a productivity tool. While it might be more at some point, my best programming weapons are still [VSCode](https://code.visualstudio.com/) and [Vim](https://www.vim.org/), sometimes [NeoVim](https://neovim.io/), and usually in combination with [TMux](https://github.com/tmux/tmux/wiki) and the [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) plugin. But I can always go into that later, or you can search for what is likely a better explanation elsewhere.

Emacs, originally short for "Editor Macros", is quite well named. People come to Emacs looking for a direct comparison between VSCode and other solutions, which is foolish, as it turns out. The best explanation I heard was that Emacs is not an editor, it is a toolkit for building the perfect editor for you. But like a lot of things, there is some assembly required.

If you don't want to assemble anything and want a more polished solution, thanks to the labour of others, then go look at [SpaceMacs](https://www.spacemacs.org/) or [Doom Emacs](https://github.com/doomemacs/doomemacs). I have a setup for the latter and it's quite good, but I wanted to learn more, so I've set up my own Emacs from scratch, as it were. As it happens, it was also with the help of [System Crafters](https://systemcrafters.net/) and [David Wilson's](https://daviwil.com/) excellent youtube videos.

Now, not everything was completely rosy up to this point. I am currently running [Debian](https://www.debian.org) 12 and it has Emacs 28.2. I did see a crash in that version so I looked upstream and found that they were up to Emacs 29.4 at that point, so I looked into how to build it myself, since for some odd reason, the GNU project is not releasing [AppImages](https://appimage.org/) and prefers instead to use their own system, [Guix](https://guix.gnu.org/). I didn't feel like using that so I went to the [Emacs Github mirror](https://github.com/emacs-mirror/emacs.git) and checked out the code. For those wanting to do that, here is my recipe:

```sh
sudo apt install autoconf automake libtool texinfo libgccjit-12-dev libgtk-4-dev libxaw7-dev libgnutls28-dev libgif-dev ripgrep libncurses-dev
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
autoreconf -vi
./configure --prefix=$HOME/emacs
```

That said, it's not like guix is hard to use on Debian, so you might actually save disk space and time if you use it. I tried it in a container and it was basically \`guix install emacs\`, so I think they're doing good work on guix. Sad that it is a competing effort instead of aligning on one good solution though. The community is fragmented enough already.

So, at this time I am primary using Emacs for one of its killer apps, which is [Org Mode](https://orgmode.org/). I am coming from [VimWiki](https://vimwiki.github.io/), which is awesome, but VimWiki does not include a productivity framework (mind you, install [TaskWarrior](https://taskwarrior.org/) and [TaskWiki](https://github.com/tools-life/taskwiki) and it gains a damn good one), and I love the fact that org-mode is all text based and also works with [NeoVim](https://github.com/nvim-orgmode/orgmode) if you set it up. Hell, even VSCode has some support for it, and if you want to move away from it, [Pandoc](https://pandoc.org/installing.html) can convert .org to .md to get you back to something that is VimWiki compatible. So I don't mind getting really into using it because I can get back out easily enough if I choose. Previously I was using TaskWarrior, but I dropped it for various reasons that I can go into another time. I am not against going back to it though, if this doesn't work out.

And that brings me to the problems that I've seen. Granted, most of my experiences have been good ones, but no one wants to hear about those. Just like slowing down to look at a car crash, you want to know what's gone wrong. So far, I've seen two major issues, not counting my own wasted time constantly tweaking my configuration.

1.  Native Compilation.

It was an experimental feature in 29.4, so I tried in my custom build, turning it on. My understanding is that while Emacs already byte-compiles elisp to bytecode, native compilation goes much further, greatly optimizing the elisp codebase. So of course I tried it.

When I first started that Emacs build I heard my CPU fan go wild. But I let it go, monitoring the compile output buffer and it told me what it was doing. I went to dinner and came back. It was still going. And the compile buffer...wasn't. For some reason it just sat there chewing a ton of CPU doing God-knows-what. I finally told it to quit, and it did. When I started it again it started up again, so I killed that build and turned the feature off.

Now in 30.1 the feature is unconditionally on. It behaved identically except when I exited and restarted, the problem went away. This does not fill me with confidence.

1.  Org Mode.

This is the killer app that pulled me back into Emacs in the first place. As it is processing a lot of text files, it is understood that performance will be an issue. This is why org-roam optimizes itself with a back-end SQLite database. I like the pure text nature of org-mode, and I am willing to put up with a little performance problem while using it from time to time. But not like the problem I recently ran into.

I am using a journal.org capture file to capture random journal entries, and the standard setup for this indents for year, month, day and then the journal entry itself. I am using some special characters to represent the bullets, and some faces (fonts) that increase in size the more important the bullets are. This normally is not a problem. But for a theme I was using [modus-vivendi](https://github.com/protesilaos/modus-themes), which is great, but I think it might have specified some faces that my system did not have, because loading my journal hung while Emacs chewed 100% cpu, and when I finally killed it and got a corefile it was in some kind of face processing code. As soon as I changed themes the problem went away, but again, this does not inspire confidence.

So, mostly my experiences have been excellent. But, it's software. Software has bugs. The question as to whether you use a piece of software is whether the bugs are something that you can tolerate.
