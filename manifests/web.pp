exec { "apt-update":
	command => "/usr/bin/apt-get -y update"
}

#package { ["openjdk-8-jre","git","maven","tomcat8","mysql-server"]:
package { ["openjdk-8-jre","git","maven","mysql-server"]:
	ensure => installed,
	require => Exec["apt-update"]
}

#service { "tomcat8":
#	ensure => running,
#	enable => true,
#	hasstatus => true,
#	hasrestart => true,
#	require => Package["tomcat8"]
#}

service { "mysql":
	ensure => running,
	enable => true,
	hasstatus => true,
	hasrestart => true,
	require => Package["mysql-server"]
}

exec { "dbcliven":
	command => "mysqladmin -uroot create dbcliven",
	unless => "mysql -uroot dbcliven",
	path => "/usr/bin",
	require => Service["mysql"]
}
