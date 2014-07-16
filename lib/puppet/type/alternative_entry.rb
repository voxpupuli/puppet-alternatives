Puppet::Type.newtype(:alternative_entry) do

  ensurable

  newparam(:name, :isnamevar => true) do
    desc 'The path to the actual alternative'

    validate do |path|
      raise ArgumentError, "path must be a fully qualified path" unless absolute_path? path
    end
  end

  newproperty(:altlink) do
    desc 'The name of the generic symlink for this alternative entry'

    validate do |path|
      raise ArgumentError, "path must be a fully qualified path" unless absolute_path? path
    end
  end

  newproperty(:altname) do
    desc 'The name of symlink in the alternatives directory'
  end

  newproperty(:priority) do
    desc 'The value of the priority of this alternative'

    validate do |prio|
      begin
        Integer(prio)
      rescue
        raise ArgumentError, "priority must be an integer"
      end
    end
  end
end
