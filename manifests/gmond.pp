# class for configuring the gmond ganglia client

class ganglia::gmond ($clustername, $headnode, $gmond_pkgname) {


  package { $gmond_pkgname:
    ensure  => installed,
  }

  file { '/etc/ganglia/gmond.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('ganglia/gmond.conf.erb'),
    require => Package[$gmond_pkgname],
    notify  => Service['gmond'],
  }

  service { 'gmond':
    ensure     => running,
    enable     => true,
    require    => File['/etc/ganglia/gmond.conf'],
    hasstatus  => true,
    hasrestart => true,
  }
}
