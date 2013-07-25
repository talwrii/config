# defaults
stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }

Exec {
      path => [
               '/sbin',
               '/bin',
               '/usr/sbin',
               '/usr/bin',
               '/usr/local/sbin',
               '/usr/local/bin',
               ],
}

$location = hiera('location','default')
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

node default {
    class {'apt::source':;}
    $deploy_arte_config = hiera('deploy_arte_config',false)
    class {
        bug:;
        home:;
        puppet:;
        apt::update:;
        dpp:;
        monit:;
        ntp::client:;
        emacs:;
        emacs::org:;
        emacs::org::sync:;
        util::generic:;
        xfce:;
        token:;
        custom:;
    }
    monit::monitor { dpp:; }
    xfce::theme { 'Nodoka-Midnight-XANi':; }
    apt::key {
        'spotify': 
	    keyid => '94558F59';
        'emacs-snapshot': 
            keyid => '2A41B42C';
	'crawl':
            keyid => 'C965A6F4';
    }

    if $is_virtual == 'true' {
        include vm
    }
    else {
        # most likely wont use spotify as music player
        package {'spotify-client':
            ensure => installed;
        }
    }

    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }
    ssl::cert {'devrandom':;}

    if $deploy_arte_config {
        include home::config::svn
        ssl::cert {'arte':;}

    }

}
