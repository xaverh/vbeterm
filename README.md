vbeterm
=======

Custom terminal based on VTE. There are many terminals available. Many
of them are based on VTE, a library implementing a terminal emulator
widget for GTK+. Some are highly configurable, some are small but none
of them match exactly my expectations.

Here is a short survey:

 - [ROXterm](http://roxterm.sourceforge.net/)
 - [Sakura](http://pleyades.net/david/sakura)
 - [Termit](http://github.com/nonstop/termit/wiki)
 - [evilvte][]
 - [gnome-terminal](http://en.wikipedia.org/wiki/gnome_terminal)
 - [lilyterm](http://lilyterm.luna.com.tw/)
 - [st](http://st.suckless.org/)
 - [xfce-terminal](http://www.xfce.org/projects/terminal/)
 - [sterm][]

`vbeterm` is really tailored to my need. You are unlikely to find it
useful. [sterm][] is a derivative with a bit more flexibility. Another
close alternative with a ability to configure before compiling is
[evilvte][].

If you plan to write your own, have a look at the exsting one. It is
likely that [evilvte][] will support what you want. If it is too
"bloated" for your taste, you can start from the
[minimal demo](http://www.calno.com/evilvte/demo.c) from the same
author. If this demo is too simplistic, you can also have a look at
[VTE's own demo](https://github.com/GNOME/vte/blob/master/src/app.vala),
written in Vala.

Also, a bold notice about VTE: this is a library whose sole purpose is
to support Gnome Terminal. If a feature is needed for Gnome Terminal,
it will be added. If a feature is not needed anymore, it will be
deprecated and removed quickly. For example, Gnome Terminal removed
the ability to set an image background. Shortly after, the
corresponding function in VTE was also removed.

For more information, see this [blog post][].

[sterm]: https://github.com/pyr/sterm
[evilvte]: http://www.calno.com/evilvte/
[blog post]: https://vincent.bernat.ch/en/blog/2017-write-own-terminal

Features
--------

 - No tab support
 - Use of VTE 2.90 (GTK3)

Installation
------------

Execute the following commands:

    $ cmake -B build
    $ cmake --build build
    $ sudo cmake --install build

(Uses the Unix Makefiles generator by default. To pick compiler: CC=clang cmake ... or -DCMAKE_C_COMPILER=clang .)

You need the VTE 2.91 development files. On Debian/Ubuntu, the package is `libvte-2.91-dev`.

Development
-----------

The project includes `compile_flags.txt` and `.clangd` so that clangd-based linters
(Vim + ALE/coc + clangd, VSCode clangd, etc.) can find `<vte/vte.h>` and GTK types
out of the box for basic editing/linting.

CMake automatically exports `compile_commands.json` (in the build directory) when configured.
For full project-wide db, point your linter at the build dir or copy/symlink it.

`bear` is still useful in some editor setups but not required for basic compilation database support.
