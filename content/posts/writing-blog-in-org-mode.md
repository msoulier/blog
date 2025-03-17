+++
title = "Blogging with org-mode"
author = ["Michael Soulier"]
date = 2025-02-02T15:50:00-05:00
lastmod = 2025-03-17T14:19:26-04:00
tags = ["hugo", "blogging"]
draft = false
weight = 2002
+++

So, as I haven't used that **other** editor in many, many years, with all of the hype around [Spacemacs](https://www.spacemacs.org/), [Doom Emacs](https://github.com/doomemacs), etc., I thought that I would take another look. Granted, [Vim](http://www.vim.org) has been forked as [NeoVim](https://neovim.io/), with fun packages to compete like [NVChad](https://nvchad.com/), but there has always been something about [Emacs](https://www.gnu.org/software/emacs/) that intriged me, and horrified me at the same time.

The joke was always that Emacs was a wonderful operating system, it just needed a decent editor. Well, if that is a reference to Vi keybindings then [evil-mode](https://github.com/emacs-evil/evil) works pretty damn well, at least as good as the [vim extension](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim) for [VS Code](https://code.visualstudio.com/). And, using Emacs keybindings isn't that hard, although it is definitely a 2-handed exercise and might possibly contribute to carpal tunnel syndrome.

It is heavyweight compared to Vim and NeoVim, and my experimental build that includes support for [libgccjit native compilation](https://akrl.sdf.org/gccemacs.html) did nearly melt my poor Dell Latitude 5400 work laptop, but in fairness, running Intellisense in VSCode on a large C++ codebase nearly did the same thing.

So, while I've pretty happy with my Vim, NeoVim and VS Code setups for writing code, my organizational tools were lacking. I did play with [Taskwarrior](https://taskwarrior.org/) for a while, and I really liked the 2.0 simple backend and taskd sync server in a docker container, but they've dropped all of that in 3.0 in favour of an SQLite backend and no taskd. I was taking notes using [VimWiki](https://vimwiki.github.io/) and it's great. Combine that with the [Vim GnuPG plugin](https://github.com/jamessan/vim-gnupg) and it was near perfect. Plus [Git](https://git-scm.com/) of course for version control and sync. But I kept running across articles on [Org Mode](https://orgmode.org/), and I was curious. So I decided to dust off my ancient Emacs config, update it, and take a solid look at org-mode.

It's still text based, so the whole thing is in Git. Love it. There's a NeoVim plugin for it which took very little to get working, so if I can't stand Emacs anymore, I'm not locked-in. There's even a VS Code plugin for it, but I think it has a way to go to keep up with the Emacs version. Being purely text, it's mostly future-proofed already. There are modes to handle GnuPG encryption of files, which is a great enhancement on my directory full of those that I finally started managing with [pass](https://www.passwordstore.org/), which is awesome BTW. Editor support for PGP is amazing for an encrypted journal, or notes full of work passwords, etc.

The editor becomes the interface to the org-mode files, hiding what needs to be hidden, rendering plain text as if it were a more sophisticated productivity tool, and well, it is. Even if many don't recognize it as such. It's fairly impressive, and I'm still not locked in. If I ever want to take my entire system back to say, Vimwiki with the files in [Markdown](https://www.markdownguide.org/) format, well, the document swiss-army knife, [Pandoc](https://pandoc.org/), can handle that. Not to mention there's a [Python module](https://orgparse.readthedocs.io/en/latest/) that can read org, and a [Go module](https://github.com/niklasfasching/go-org), so conversion would not be that difficult.

This blog is done with [Hugo](https://gohugo.io/), so the content is all Markdown. The cool thing is that you can build the blog [with org-mode](https://andreyor.st/posts/2022-10-16-my-blogging-setup-with-emacs-and-org-mode/) where all of the posts are in a single file. So far I am really liking it too. I could repeat what others have already said so well, but what's the point? The details are all linked from here, so if you really want to know, follow them and read up.

Oh, one last thing. Emacs in Debian 12 ([Bookworm](https://www.debian.org/releases/bookworm/)), is not up to the latest, which at this time is 29.4. So I grabbed the code from the [Github mirror](https://github.com/emacs-mirror/emacs.git), installed a few packages to build against, and built it to install in my home directory like so:

```bash
sudo apt install texinfo libgccjit-12-dev libgtk-4-dev libxaw7-dev libgnutls28-dev libgif-dev ripgrep
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
autoreconf -vi
./configure --prefix=$HOME/emacs
make
make install
```

So if I want to get rid of it I just blow away that emacs directory. And I put it into my path of course.

```bash
# Custom emacs build
if [ -d $HOME/emacs ]; then
    export PATH="$HOME/emacs/bin:$PATH"
fi
```

I'm still learning about Emacs packaging of plugins but I'll write about that later. So far I'm quite happy with this setup, but I have a long way to go to make it comfortable. I'll add more on this topic as I learn more.

Cheers.
