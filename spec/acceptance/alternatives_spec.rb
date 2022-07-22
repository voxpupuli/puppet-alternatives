# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'alternatives type' do
  let(:pp) do
    <<-PP
      # Note that debian 10 & 11 do not have a merged /bin & /usr/bin.
      alternative_entry {'/usr/bin/yes':
          ensure   => present,
          altlink  => '/usr/bin/dne',
          altname  => 'dne',
          priority => 10,
      }

      alternative_entry {'/usr/bin/toe':
          ensure   => present,
          altlink  => '/usr/bin/dne',
          altname  => 'dne',
          priority => 20,
      }

      alternative_entry {'/usr/bin/wc':
          ensure   => present,
          altlink  => '/usr/bin/dne',
          altname  => 'dne',
          priority => 30,
      }

      Alternative_entry<| |>
      -> alternatives { 'dne':
        path => '/usr/bin/toe',
      }
    PP
  end

  it_behaves_like 'an idempotent resource'

  describe file('/usr/bin/dne') do
    it { is_expected.to be_symlink }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
    it { is_expected.to be_linked_to '/etc/alternatives/dne' }
  end

  describe file('/etc/alternatives/dne') do
    it { is_expected.to be_symlink }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
    it { is_expected.to be_linked_to '/usr/bin/toe' }
  end
end
