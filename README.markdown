puppet-alternatives
===================

Manage alternatives symlinks.

Synopsis
--------

Using `puppet resource` to inspect alternatives

    root@master:~# puppet resource alternatives
    alternatives { 'aptitude':
      path => '/usr/bin/aptitude-curses',
    }
    alternatives { 'awk':
      path => '/usr/bin/mawk',
    }
    alternatives { 'builtins.7.gz':
      path => '/usr/share/man/man7/bash-builtins.7.gz',
    }
    alternatives { 'c++':
      path => '/usr/bin/g++',
    }
    alternatives { 'c89':
      path => '/usr/bin/c89-gcc',
    }
    alternatives { 'c99':
      path => '/usr/bin/c99-gcc',
    }
    alternatives { 'cc':
      path => '/usr/bin/gcc',
    }

- - -

Using `puppet resource` to update an alternative

    root@master:~# puppet resource alternatives editor
    alternatives { 'editor':
      path => '/bin/nano',
    }
    root@master:~# puppet resource alternatives editor path=/usr/bin/vim.tiny
    notice: /Alternatives[editor]/path: path changed '/bin/nano' to '/usr/bin/vim.tiny'
    alternatives { 'editor':
      path => '/usr/bin/vim.tiny',
    }

- - -

Using the alternatives resource in a manifest:

    class ruby::193 {

      package { 'ruby1.9.3':
        ensure => present,
      }

      # Will also update gem, irb, rdoc, rake, etc.
      alternatives { 'ruby':
        path    => '/usr/bin/ruby1.9.3',
        require => Package['ruby1.9.3'],
      }
    }

    # magic!
    include ruby::193

- - -

This module should work on any Debian and RHEL based distribution.

Contact
-------

  * Source code: https://github.com/adrienthebo/puppet-alternatives
  * Issue tracker: https://github.com/adrienthebo/puppet-alternatives/issues
