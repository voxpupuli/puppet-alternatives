Puppet::Type.type(:alternative_entry).provide(:dpkg) do

  confine :osfamily => 'Debian'
  commands :update  => '/usr/sbin/update-alternatives'
  
  mk_resource_methods

  def create
    update('--install',
      @resource.value(:altlink),
      @resource.value(:altname),
      @resource.value(:name),
      @resource.value(:priority)
    )
  end

  def exists?
    # we cannot fetch @resource.value(:altname) if running 'puppet resource alternative_entry'
    temp_altname = altname
    temp_altname = @resource.value(:altname) if @resource.value(:altname)

    output = update('--list', temp_altname)

    output.split(/\n/).map(&:strip).any? do |line|
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
      altname = line.split(/\s+/).first
      query_alternative(altname).each do |alt|
        entries << new(alt)
      end
    end

    entries
  end

  ALT_QUERY_REGEX = %r[Alternative: (.*?)$.Priority: (.*?)$]m

  def self.query_alternative(altname)
    output = update('--query', altname)

    altlink = output.match(/Link: (.*)$/)[1]

    output.scan(ALT_QUERY_REGEX).map do |(path, priority)|
      {:altname => altname, :altlink => altlink, :name => path, :priority => priority}
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

  private

  def rebuild(&block)
    destroy
    yield
    create
  end
end
