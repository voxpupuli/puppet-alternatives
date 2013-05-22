Puppet::Type.type(:alternatives).provide(:redhat) do

  confine :osfamily => 'RedHat'
  commands :update => '/usr/sbin/update-alternatives'

  # Return all instances for this provider
  #
  # @return [Array<Puppet::Type::Alternatives::ProviderDpkg>] A list of all current provider instances
  def self.instances
    all.map { |name, attributes| new(:name => name, :path => attributes[:path]) }
  end

  # Generate a hash of hashes containing a link name and associated properties
  # @return [Hash<String, Hash<Symbol, String>>]
  def self.all
    alts = Dir.new('/var/lib/alternatives').reject { |f| %w(. ..).include?(f) }
    alts.inject({}) do |hash, alt|
      output = update('--display', alt)
      lines = output.split("\n")

      if lines[0] =~ /^#{alt} - status is auto\.$/
        hash[alt] = {:path => 'auto'}
      elsif lines[1] =~ /link currently points to (.+)$/
        hash[alt] = {:path => $1}
      end

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
    if newpath == 'auto'
      update('--auto', name)
    else
      update('--set', name, newpath)
    end
  end
end
