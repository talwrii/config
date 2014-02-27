class home::config (
    $gpgid = hiera('gpgid',false),
    $multiplex_ssh = hiera('multiplex_ssh', false),
) {
    include home::common
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
        shell  => '/bin/bash',
    }
    File {
        owner => xani,
        group => xani,
    }
    $git = $home::common::git
    home::config::file {
        bash_prompt:;
        bashrc:;
        gitconfig:;
        gitignore_global:;
        htoprc:;
        inputrc:;
        perlconsolerc:;
        screenrc:;
#        toprc:; # broken with puppet 3.3.x coz not utf
        xsessionrc:;
        terminator:
            target => ".config/terminator/config";
        arbtt:
            source => 'home/arbtt-categorize.cfg.erb',
            target => '.arbtt/categorize.cfg';
        tilda:
            target => '.tilda/config_0';
    }
    home::config::exec {
        git-wtf:;
        ssh-askpass-wrapper:;
        notify-wrapper:;
        puppet-notify:;
    }
    home::config::code_tmp {
        erb:;
        pl:;
        pp:;
        sh:;
        mojo:;
    }
    home::dir {
        '.config':;
        '.config/terminator':;
        '.tilda':;
    }

    home::config::autostart {'tilda': command => 'bash -c "echo $(sleep 20 ; tilda) &"'}

    file {'xani-ssh-config-dir':
        path   => "$homedir/.ssh",
        ensure => directory,
        mode   => 700,
    }
    if $multiplex_ssh {
        file {"${homedir}/.ssh/mux":
            ensure => directory,
        }
    }

    file { 'xani-ssh-config':
        path    => "${homedir}/.ssh/config",
        content => template('home/ssh_config.erb'),
        mode    => 600,
        require => File['xani-ssh-config-dir'],
    }
}

define home::config::file (
        $source = "home/${title}.erb",
        $target = ".${title}",
        $mode   = 644,
    ) {
    include home::common
    $homedir = $home::common::homedir
    file { "${homedir}/$target":
        content => template($source),
        owner   => xani,
        mode    => $mode,
    }
}

define home::dir ($mode = '755') {
    include home::common
    $homedir = $home::common::homedir
    file { "${homedir}/${title}":
        ensure => directory,
        owner  => xani,
        group  => xani,
        mode   => $mode,
    }
}

define home::config::code_tmp (
    $source = "home/code_tmp/${title}.erb",
    $target = "/tmp/1.${title}",
    ) {
    file { $target:
        content => template($source),
        mode    => 755,
        owner   => xani,
        replace => no,
    }
}

define home::config::exec (
    $source = "home/exec/${title}.erb",
    $target = "/usr/local/bin/${title}",
    ) {
    file { $target:
        content => template($source),
        mode    => 755,
        owner   => xani,
    }
}

class home::config::svn {
    home::config::exec { svn-commit:; }

    package { 'subversion':
        ensure => installed,
    }
}
define home::config::autostart (
    $command,
    $description = $title,
    $comment = "Comment not defined",
    $icon = "",
    $terminal = false,
) {
    require home::common
    $homedir = $home::common::homedir
    file {"${homedir}/.config/autostart/${title}.desktop":
        content => template('home/autostart.desktop'),
        mode    => 644,
        owner   => xani,
        group   => xani,
    }
}
