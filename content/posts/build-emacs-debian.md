+++
title = "Compile a custom emacs 29.4 on Debian 12"
author = ["Michael Soulier"]
date = 2025-05-16T09:33:00-04:00
lastmod = 2025-05-16T11:57:51-04:00
tags = ["linux", "emacs"]
categories = ["fun"]
draft = false
weight = 2005
+++

So, while I do love Debian, it does often show its age. It is very stable, and to remain stable it is often using older versions of software. When I decided to get back into Emacs for org-mode, I found it easier to use a more recent version than Debian provides. This turned out to be fairly simple.

```sh
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
sudo apt install autoconf automake libtool texinfo libgccjit-12-dev libgtk-4-dev libxaw7-dev libgnutls28-dev libgif-dev ripgrep libncurses-dev makeinfo
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
autoreconf -vi
./configure --prefix=$HOME/emacs --with-native-compilation
make -j8
make install
```

Optionally, if you want pgtk support:

```sh
sudo apt install build-essential libgtk-3-dev libgnutls28-dev libtiff5-dev libgif-dev libjpeg-dev libpng-dev libxpm-dev libncurses-dev texinfo makeinfo
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
./autogen.sh
./configure --with-pgtk --prefix=$HOME/emacs --with-native-compilation
make -j8
make install
```

Then I just put $HOME/emacs/bin in my path and I'm good. Actually I have multiple versions, I make $HOME/emacs a symlink that points at $HOME/emacs.29.4 and $HOME/emacs.30.1, for example.

Sometimes you just need to build from source.
