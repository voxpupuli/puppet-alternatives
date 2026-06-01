# frozen_string_literal: true

Puppet::Type.type(:alternative_entry).provide(:dpkg) do
  confine 'os.family' => %i[debian suse]
  defaultfor [{ 'os.name' => %i[debian ubuntu], 'os.family' => :suse }]

  commands update: 'update-alternatives'

  mk_resource_methods

  def create
    puts 'create block called'
=begin
COMMANDS
       --install link name path priority [--slave link name path]...
update-alternatives --install
           /usr/sbin/ip6tables #generic-name/alternative-link
           ip6tables #name-in-/etc/alternatives.d
           /usr/sbin/ip6tables-legacy #path 
           10 #piriority
           --slave
           /usr/sbin/ip6tables-restore
           ip6tables-restore
           /usr/sbin/ip6tables-legacy-restore
           --slave
           /usr/sbin/ip6tables-save
           ip6tables-save
           /usr/sbin/ip6tables-legacy-save
=end
    update('--install',
           @resource.value(:altlink),
           @resource.value(:altname),
           @resource.value(:name),
           @resource.value(:priority),
           *(@resource.value(:slavearray)))
  end

  def exists?
    # we cannot fetch @resource.value(:altname) if running 'puppet resource alternative_entry'
    begin
      output = update('--list', @resource.value(:altname) || altname)
    rescue StandardError
      return false
    end

    output.split(%r{\n}).map(&:strip).any? do |line|
      line == @resource.value(:name)
    end
  end

  def destroy
    update('--remove', @resource.value(:altname), @resource.value(:name))
  end

  def self.instances
    output = update('--get-selections')

    entries = []

    output.each_line do |line|
      altname = line.split(%r{\s+}).first
      query_alternative(altname).each do |alt|
        entries << new(alt)
      end
    end

    entries
  end

  def self.prefetch(resources)
    catalog = resources.values.first.catalog
    instances.each do |prov|
      catalog.resources.each do |item|
        item.provider = prov if item.instance_of?(Puppet::Type::Alternative_entry) && item.name == prov.name && item.parameter('altlink').value == prov.altlink
      end
    end
  end

  ALT_QUERY_REGEX = %r{Alternative: (.*?)$.Priority: (.*?)$}m.freeze # rubocop:disable Lint/ConstantDefinitionInBlock

  def self.query_alternative(altname)
    output = update('--query', altname)

    altlink = output.match(%r{Link: (.*)$})[1]

    output.scan(ALT_QUERY_REGEX).map do |(path, priority)|
      { altname: altname, altlink: altlink, name: path, priority: priority }
    end
  end

  def name=(new_name)
    rebuild do
      @property_hash[:name] = new_name
    end
  end

  def altname=(new_altname)
    rebuild do
      @property_hash[:altname] = new_altname
    end
  end

  def altlink=(new_altlink)
    rebuild do
      @property_hash[:altlink] = new_altlink
    end
  end

  def priority=(new_priority)
    rebuild do
      @property_hash[:priority] = new_priority
    end
  end

  def slavearray=(new_slavearray)
    rebuild do
      @property_hash[:priority] = new_slavearray
    end
  end

  private

  def rebuild(&_block)
    destroy
    yield
    create
  end
end
