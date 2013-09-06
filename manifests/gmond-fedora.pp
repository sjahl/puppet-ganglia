# class for configuring the gmond ganglia client

class ganglia::gmond-fedora ($clustername, $headnode) {

  $packages = 'ganglia-gmond'

  package { $packages:
    ensure  => installed,
  }

  file { '/etc/ganglia/gmond.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('ganglia/gmond.conf.erb'),
    require => Package['ganglia-gmond'],
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
