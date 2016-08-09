require 'spec_helper'

describe Puppet::Type.type(:alternatives).provider(:rpm) do
  def my_fixture(path)
    File.join(PROJECT_ROOT, 'spec', 'fixtures', 'unit', 'provider', 'alternatives', 'rpm', path)
  end

  def my_fixture_read(path)
    File.read(my_fixture(path))
  end

  let(:stub_selections) do
    {
      'editor' => { mode: 'manual', path: '/usr/bin/vim.tiny' },
      'mta'    => { mode: 'manual', path: '/usr/sbin/sendmail' },
    }
  end

  describe '.all' do
  end

  describe '.instances' do
    it 'delegates to .all' do
      described_class.expects(:all).returns(stub_selections)
      described_class.expects(:new).twice.returns(stub)
      described_class.instances
    end
  end

  describe 'instances' do
    subject { described_class.new(name: 'editor') }

    let(:resource) { Puppet::Type.type(:alternatives).new(name: 'editor') }

    before do
      Puppet::Type.type(:alternatives).stubs(:defaultprovider).returns described_class
      resource.provider = subject
      described_class.stubs(:all).returns(stub_selections)
    end

    it '#path retrieves the path from class.all' do
      expect(subject.path).to eq('/usr/bin/vim.tiny')
    end

    it '#path= updates the path with update-alternatives --set' do
      subject.expects(:alternatives).with('--set', 'editor', '/bin/nano')
      subject.path = '/bin/nano'
    end
  end
end
