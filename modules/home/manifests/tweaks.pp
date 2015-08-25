class home::tweaks {
    # nobody wants you imagemagick, fuck off, you are not a real image viewer
    file {[
           '/usr/share/applications/display-im6.q16.desktop',
           '/usr/share/applications/display-im6.desktop',
           ]:
               ensure => absent
    }
    # nuke it from orbit, it is only way to be sure (non-current translation is useless)
    file {[
           '/usr/share/man/pl',
           '/usr/share/man/pl.ISO8859-2',
           ]:
               backup => false,
               purge  => true,
               recurse => true,
               force  => true,
               ensure => directory,
    }

}
