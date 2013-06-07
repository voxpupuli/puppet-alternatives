require 'spec_helper'

describe Puppet::Type.type(:alternatives) do

  describe 'property `path`' do
    it 'passes validation with an absolute path' do
      expect { described_class.new(:name => 'ruby', :path => '/usr/bin/ruby1.9') }.to_not raise_error
    end
    it 'fails validation without an absolute path' do
      expect { described_class.new(:name => 'ruby', :path => "The bees they're in my eyes") }.to raise_error Puppet::Error, /must be a fully qualified path/
    end
  end

  describe 'validating the mode', :pending => 'Type level validation' do
    it "raises an error if the mode is auto and a path is set" do
      expect {
        described_class.new(:name => 'thing', :mode => 'auto', :path => '/usr/bin/explode')
      }.to raise_error Puppet::Error, /Mode cannot be 'auto'/
    end

    it "raises an error if the mode is manual and a path is not set" do
      expect {
        described_class.new(:name => 'thing', :mode => 'manual').validate
      }.to raise_error Puppet::Error, /Mode cannot be 'manual'/
    end
  end
end
