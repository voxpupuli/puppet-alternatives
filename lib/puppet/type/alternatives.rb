# frozen_string_literal: true

Puppet::Type.newtype(:alternatives) do
  feature :mode, 'The alternative can provide auto and manual modes'

  newparam(:name, isnamevar: true) do
    desc 'The name of the alternative.'
  end

  newproperty(:path) do
    desc 'The path of the desired source for the given alternative. On RedHat, a family can be specified instead'

    def insync?(is)
      if absolute_path? should
        is == should
      else
        provider.family == should
      end
    end

    validate do |path|
      raise ArgumentError, 'path must be a fully qualified path' unless (absolute_path? path) || (Facter.value(:osfamily) == 'RedHat')
    end
  end

  newproperty(:mode, required_features: [:mode]) do
    desc 'Use the automatic option for this alternative'

    newvalue('auto')
    newvalue('manual')
  end

  validate do
    case self[:mode]
    when :auto
      raise Puppet::Error, "Mode cannot be 'auto' if a path is given" if self[:path]
    when :manual
      raise Puppet::Error, "Mode cannot be 'manual' without a path" unless self[:path]
    end
  end

  autorequire(:alternative_entry) do
    self[:path]
  end
end
