alternative_entry { '/usr/bin/gcc-14':
  ensure   => present,
  altlink  => '/usr/bin/gcc',
  altname  => 'gcc',
  priority => 10,
#  --slave /etc/alternatives/editor editor.1.gz /usr/share/man/man1/vim.1.gz
  slavearray => ['--slave', '/etc/alternatives/editor',  'editor.1.gz',  '/usr/share/man/man1/vim.1.gz'],
}