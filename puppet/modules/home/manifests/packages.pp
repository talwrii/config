class home::packages {
    include home::common
    package {
        [
         # system
         anacron,
         # terminal
         xfonts-terminus,
         xfonts-terminus-dos,
         xfonts-terminus-oblique,
         fonts-liberation,
         fonts-droid,
         terminator,
         # utils
         zile,
         meld,
         wireshark,
         scrot,
         shutter,
         git,
         mc,
         sshfs,
         gtklp,
         cups-pdf,
         libnotify-bin,
         pkg-mozilla-archive-keyring,
         perlconsole,
         perltidy,
         libcapture-tiny-perl,
         colordiff,
         gnome-gpg,
         seahorse,
         youtube-dl,
         xtightvncviewer,
         #dev crap
         cpanminus,
         libjson-perl,
         libyaml-perl,
         libfile-slurp-perl,
         gdb-multiarch,
         # R analysis tools
         rkward,
         #
         arbtt,
         ]:
             ensure => installed,

    }
    # for some bullshit reason a lot of packages recommend apache; fuck them
    service { apache2:
        ensure => stopped,
        enable => false,
    }
    # polish translations are crap and/or outdated
    package {
        [
         manpages-pl,
         manpages-pl-dev,
         ]:
             ensure => absent;
    }
}


