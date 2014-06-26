# manage filetest
class tomcat7{

      package { 'wget':
              ensure => installed,
      }

      exec { 'apt-get update':
           command => 'apt-get update',
     path => ['/usr/bin'],
           
      }

      package { 'openjdk-7-jdk':
            ensure => installed, 
            require => Exec['apt-get update'],
      }

      package { 'tomcat7':
              ensure => installed,
                  require => Package['openjdk-7-jdk'],
      }
      service { 'tomcat7':
        ensure => running, 
        require => Package['tomcat7'],
      }
      
      exec { 'sample-war':
        require => [ 
        Service['tomcat7'], 
              Package['wget']
        ],
        command => 'wget https://s3.amazonaws.com/cloudbees-bucket/SimpleServlet.war -P /tmp/',
        path => ['/usr/bin'],
      }
      exec { 'delete-war-from-webapps':
        command => 'rm -rf /var/lib/tomcat7/webapps/SimpleServlet*',
        path => ['/bin'],
      }

      file { '/var/lib/tomcat7/webapps/SimpleServlet.war':
           source => '/tmp/SimpleServlet.war',
     require => Exec['sample-war', 'delete-war-from-webapps'],
      }
}
