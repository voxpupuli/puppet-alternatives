Puppet::Type.type(:alternative_entry).provide(:rpm) do
  confine :osfamily => :redhat
  defaultfor :osfamily => :redhat

  commands :alternatives => '/usr/sbin/alternatives'

  mk_resource_methods

  def create
    alternatives('--install',
                 @resource.value(:altlink),
                 @resource.value(:altname),
                 @resource.value(:name),
                 @resource.value(:priority)
    )
  end

  def exists?
    output = Dir.glob('/var/lib/alternatives/*').map { |x| File.basename(x) }

    output.each do |altname|
      altname == @resource.value(:name)
    end
  end

  def destroy
    begin
      alternatives('--remove', @resource.value(:altname), @resource.value(:name))
    rescue
    end
  end

  def self.instances
    output = Dir.glob('/var/lib/alternatives/*').map { |x| File.basename(x) }

    entries = []

    output.each do |altname|
      query_alternative(altname).each do |alt|
        entries << new(alt)
      end
    end

    entries
  end

  def self.prefetch(resources)
    instances.each do |prov|
      # rubocop:disable Lint/AssignmentInCondition
      if resource = resources[prov.name]
        # rubocop:enable Lint/AssignmentInCondition
        resource.provider = prov
      end
    end
  end

  ALT_RPM_QUERY_REGEX = / link currently points to (.*?)$.* - priority (.*?)$/m

  def self.query_alternative(altname)
    output = alternatives('--display', altname)

    output.scan(ALT_RPM_QUERY_REGEX).map do |(path, priority)|
      altlink = File.readlines('/var/lib/alternatives/' + altname)[1].chomp
      { :altname => altname, :altlink => altlink, :name => path, :priority => priority }
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

  def rebuild(&_block)
    destroy
    yield
    create
  end
end
