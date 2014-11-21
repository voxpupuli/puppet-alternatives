Puppet::Type.type(:alternative_entry).provide(:dpkg) do

  confine :osfamily => 'Debian'
  defaultfor :operatingsystem => [:debian, :ubuntu]

  commands :update => 'update-alternatives'
  
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
    begin
      output = update('--list', @resource.value(:altname) || altname)
    rescue
      return false
    end

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
  
  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
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
