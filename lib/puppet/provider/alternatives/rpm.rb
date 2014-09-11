Puppet::Type.type(:alternatives).provide(:rpm) do

  confine    :osfamily => :redhat
  defaultfor :osfamily => :redhat

  commands :alternatives => '/usr/sbin/alternatives'

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
    output = Dir.glob('/var/lib/alternatives/*').map { |x| File.basename(x) }

    output.inject({}) do |hash, name|
      path = File.readlink('/etc/alternatives/' + name)
      hash[name] = {:path => path}
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
end
