+++
title = "Go for desktop tools over Python"
author = ["Michael Soulier"]
date = 2025-09-13T22:47:00-04:00
lastmod = 2025-09-13T18:55:32-04:00
tags = ["golang", "python", "linux"]
categories = ["fun"]
draft = false
weight = 2009
+++

So for some time I have primarily used [Python](https://python.org) as my language of choice for most
projects, and for my own desktop tools. Python is a very powerful choice for
server-side solutions, and can definitely be used for desktop tools but does
offer some problems.

Inevitably, Python solutions require Python modules. If your OS packages them
then maybe you can use the native packaging solution to install them, but I
often find that this is not the case. I don't like to install modules globally
outside of the packaging system, so I end up making liberal use of [virtualenvs](https://docs.python.org/3/library/venv.html),
but then it gets worse when you need a specific Python version.

So then, I got into managing everything with the magic of [PyEnv](https://github.com/pyenv/pyenv). It does get
complicated this way, even if it works. I prefer to simplify. I could just do
everything in C/C++, but that isn't simple either, even if I am maintaining my
own little [C library](https:://github.com/msoulier/mikelibc.git), and a [C++ library](https://github.com/msoulier/mikelibcpp.git) built on top of it.

Then I started playing with [Go](https://go.dev/), a horribly named language created by Google
designed to be much like a more modern version of C, with the performance of
native compilation, all of the modern OO features that one really tends to care
about, and garbage collection. It trivially permits pulling in other open-source
libraries from Git repos like on [GitHub](https://github.com), and as long as you keep your code in
pure Go, most if it will be portable to Windows, Linux, MacOSX, etc.,
trivially.

In fact, you can cross compile with nearly zero effort, most of the time just by
supplying the \`GOOS\` environment variable. It is strongly typed, but still quite
easy to work with, and all of the binaries are statically linked, so you don't
have to ship any supporting libraries onto the production environment.

As an example, here is a one-liner for running a web server locally:

```sh
    # install goexec: go install github.com/shurcooL/goexec@latest
    goexec 'http.ListenAndServe(`:8080`, http.FileServer(http.Dir(`.`)))'
```

I am slowly porting my personal tools to it, not to mention using it more at
work. As a desktop tool language, it's hard to beat.
