alternative_entry { '/usr/bin/gcc-14':
  ensure   => present,
  altlink  => '/usr/bin/gcc',
  altname  => 'gcc',
  priority => 10,
}