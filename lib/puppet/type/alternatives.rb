Puppet::Type.newtype(:alternatives) do

  newparam(:name, :isnamevar => true) do
    desc "The name of the alternative."
  end

  newproperty(:path) do
    desc "The path of the desired source for the given alternative"

    validate do |path|
      raise ArgumentError, "path must be a fully qualified path" unless absolute_path? path
    end
  end
end
