# class for configuring the gmetad ganglia server
# trustedhosts should be a space-separated list of gmetad hosts

class ganglia::gmetad ($clustername, $gridname, $trustedhosts, $gmetad_pkgname) {

  package { $pkgname:
    ensure  => installed,
  }

  file { '/etc/ganglia/gmetad.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('ganglia/gmetad.conf.erb'),
    require => Package[$gmetad_pkgname],
    notify  => Service['gmetad'],
  }

  service { 'gmetad':
    ensure     => running,
    enable     => true,
    require    => File['/etc/ganglia/gmetad.conf'],
    hasstatus  => true,
    hasrestart => true,
  }
}
