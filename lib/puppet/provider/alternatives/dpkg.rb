Puppet::Type.type(:alternatives).provide(:dpkg) do

  confine :osfamily => :debian
  defaultfor :operatingsystem => [:debian, :ubuntu]

  commands :update => 'update-alternatives'

  has_feature :mode

  # Return all instances for this provider
  #
  # @return [Array<Puppet::Type::Alternatives::ProviderDpkg>] A list of all current provider instances
  def self.instances
    all.map { |name, attributes| new(:name => name, :path => attributes[:path]) }
  end

  # Generate a hash of hashes containing a link name and associated properties
  #
  # This is structured as {'key' => {attributes}} to do fast lookups on entries
  #
  # @return [Hash<String, Hash<Symbol, String>>]
  def self.all
    output = update('--get-selections')

    output.split(/\n/).inject({}) do |hash, line|
      name, mode, path = line.split(/\s+/)
      hash[name] = {:path => path, :mode => mode}
      hash
    end
  end

  # Retrieve the current path link
  def path
    name = @resource.value(:name)
    if (attrs = self.class.all[name])
      attrs[:path]
    end
  end

  # @param [String] newpath The path to use as the new alternative link
  def path=(newpath)
    name = @resource.value(:name)
    update('--set', name, newpath)
  end

  # @return [String] The alternative mode
  def mode
    output = update('--display', @resource.value(:name))
    first = output.split("\n").first

    if first.match /auto mode/
      'auto'
    elsif first.match /manual mode/
      'manual'
    else
      raise Puppet::Error, "Could not determine if #{self} is in auto or manual mode"
    end
  end

  # Set the mode to auto.
  def mode=(_)
    update('--auto', @resource.value(:name))
  end
end
