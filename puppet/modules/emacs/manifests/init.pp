class emacs ( $homedir = hiera('homedir','/home/xani'),  $deploy_portable_config = hiera('deploy_portable_config',false) ) {
    package { magit: # emacs git
        ensure => installed,
        require => Package['emacs23'],
    }

    package { emacs23:
        ensure => installed,
    }

    package { ['emacs23-el',
               'emacs-goodies-el',
               'lua-mode',
               'org-mode',
               'sepia', # Simple Emacs-Perl InterAction
               'twittering-mode',
               'emacs-jabber',
               'texlive-latex-base',
               'puppet-lint',
               'yaml-mode',
               'wl-beta',
               'bbdb',
               'xprintidle']:
        ensure => installed,
        require => Package['emacs23'],
    }

    file { 'run_emacs':
        path => '/usr/local/bin/e',
        source => "$modules/emacs/files/e",
        owner => root,
        mode => 755,
    }
    file { emacs-config:
        path => "$homedir/.emacs-legacy",
        owner => xani,
        group => xani,
        mode => 644,
        content => template('emacs/emacs.erb'),
    }
    file { emacs-config-modular:
        path => "$homedir/.emacs",
        owner => xani,
        group => xani,
        mode => 644,
        content => template('emacs/emacs.modular.erb'),
    }
    file { emacs-wanderlust-config:
        path => "$homedir/.wl",
        owner => xani,
        group => xani,
        mode => 600,
        content => template('emacs/emacs.wl.erb'),
    }
    file { emacs-wanderlust-folder-config:
        path => "$homedir/.folders",
        owner => xani,
        group => xani,
        mode => 600,
        content => template('emacs/emacs.folders.erb'),
    }
    file { xani-emacs-dir:
        path => "$homedir/emacs",
        ensure => directory,
        purge => true,
        force => true,
        owner => xani,
        group => xani,
        require => File['xani-src'],
    }

    file { xani-emacs-libs:
        path => "$homedir/emacs/lib",
        ensure => directory,
        source => "$modules/emacs/files/emacs-libs",
        recurse => true,
        purge => true,
        force => true,
        owner => xani,
        group => xani,
        require => File['xani-emacs-dir'],
    }

    file { xani-emacs-xani-libs:
        path => "$homedir/emacs/xani-lib",
        ensure => directory,
        source => "$modules/emacs/files/parts",
        recurse => true,
        purge => true,
        force => true,
        owner => xani,
        group => xani,
        require => File['xani-emacs-dir'],
    }

    file { xani-emacs-icons:
        path => "$homedir/emacs/icons",
        ensure => directory,
        source => "$modules/emacs/files/emacs-icons",
        recurse => true,
        purge => true,
        force => true,
        owner => xani,
        group => xani,
        require => File['xani-emacs-dir'],
    }
    file { xani-emacs-autoinsert:
        path => "$homedir/emacs/autoinsert",
        ensure => directory,
        source => "$modules/emacs/files/emacs-autoinsert",
        recurse => true,
        purge => true,
        force => true,
        owner => xani,
        group => xani,
        require => File['xani-emacs-dir'],
    }
    file { puppet-lint-wrapper:
        path    => '/usr/local/bin/puppet-lint-wrapper',
        mode    => 755,
        owner   => root,
        content => template('emacs/puppet-lint-wrapper.erb'),
    }
    # this have to be at end
    if $deploy_portable_config {
        $portable_config = 1
        file { emacs-config-arte:
            path => "$homedir/src/svn-puppet/modules/artegence/files/xani/emacs",
            owner => xani,
            group => xani,
            mode => 644,
            content => template('emacs/emacs.erb'),
        }
    }
}

class emacs::org ($cron_hour = '*', $cron_minute = '*/5', $homedir = '/home/xani' ) {
    file { xani-emacs-org-share:
        path => "$homedir/emacs/org/share",
        ensure => directory,
        owner => xani,
        group => xani,
        require => File['xani-emacs-org'],
    }
    if $::location == 'arte' {
        file { xani-emacs-org-arte:
            path => "$homedir/emacs/org/arte",
            ensure => directory,
            owner => xani,
            #        group => xani,
            require => File['xani-emacs-org'],
        }
        cron { 'xani-org-update-arte':
            command => "/home/xani/emacs/org/arte/c",
            user    => xani,
            hour    => '*',
            minute  => '*/5',
        }
    }
    file { xani-emacs-org:
        path => "$homedir/emacs/org",
        ensure => directory,
        owner => xani,
        group => xani,
        require => File['xani-emacs-dir'],
    }

    exec { create-org-share:
        cwd => "$homedir/emacs/org",
        creates => "$homedir/emacs/org/share/.git",
        logoutput => true,
        command => "/usr/bin/git clone ssh://git@devrandom.pl/org-todo.git $homedir/emacs/org/share",
        user => xani,
        require => [Package['git'], File['xani-emacs-org-share'],]
    }

    cron { 'xani-org-update':
        command => "/home/xani/emacs/org/share/c",
        user    => xani,
        hour    => $cron_hour,
        minute  => $cron_minute,
    }

    # Orage sync
    file { update-orage-calendar:
        path    => '/usr/local/bin/update-orage-calendar',
        content => template('emacs/update-orage-calendar.erb'),
        mode    => 755,
        owner   => root,
    }

    cron { 'xani-orage-update':
        command => "/usr/local/bin/update-orage-calendar",
        user    => xani,
        minute  => '*/10',
    }

}

