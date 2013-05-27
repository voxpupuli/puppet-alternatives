require 'spec_helper'

describe Puppet::Type.type(:alternatives) do

  describe 'property `path`' do
    it 'passes validation with an absolute path' do
      expect { described_class.new(:name => 'ruby', :path => '/usr/bin/ruby1.9') }.to_not raise_error
    end
    it 'fails validation without an absolute path' do
      expect { described_class.new(:name => 'ruby', :path => "The bees they're in my eyes") }.to raise_error Puppet::ResourceError, /must be a fully qualified path/
    end
  end
end
