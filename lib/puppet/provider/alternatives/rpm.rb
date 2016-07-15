Puppet::Type.type(:alternatives).provide(:rpm) do

  confine    :osfamily => :redhat
  defaultfor :osfamily => :redhat

  has_feature :mode

  commands :alternatives => '/usr/sbin/alternatives'

  # Return all instances for this provider
  #
  # @return [Array<Puppet::Type::Alternatives::ProviderDpkg>] A list of all current provider instances
  def self.instances
    all.map { |name, attributes| new(:name => name, :path => attributes[:path], :mode => attributes[:mode]) }
  end

  # Generate a hash of hashes containing a link name and associated properties
  #
  # This is structured as {'key' => {attributes}} to do fast lookups on entries
  #
  # @return [Hash<String, Hash<Symbol, String>>]
  def self.all
    output = Dir.glob('/var/lib/alternatives/*').map { |x| File.basename(x) }

    output.inject({}) do |hash, name|
      path = File.readlink('/etc/alternatives/' + name)
      mode = File.open('/var/lib/alternatives/' + name) {|f| f.readline}
      Puppet.debug "Alternatives Name: #{name}. Discovered mode: #{mode}."
      hash[name] = {:path => path, :mode => mode}
      hash
    end
  end

  # Retrieve the current path link
  def path
    name = @resource.value(:name)
    self.class.all[name][:path]
  end

  # @param [String] newpath The path to use as the new alternative link
  def path=(newpath)
    name = @resource.value(:name)
    alternatives('--set', name, newpath)
  end

  def mode
    output = alternatives('--display', @resource.value(:name))
    first = output.split("\n").first

    if first.match(/status is auto/)
      'auto'
    elsif first.match(/status is manual/)
      'manual'
    else
      fail Puppet::Error, "Could not determine if #{self} is in auto or manual mode"
    end
  end

  # Set the mode to manual or auto.
  # @param [Symbol] newmode Either :auto or :manual for the alternatives mode
  def mode=(newmode)
    if newmode == :auto
      alternatives('--auto', @resource.value(:name))
    elsif newmode == :manual
      # No change in value, but sets it to manual
      alternatives('--set', name, path)
    end
end
