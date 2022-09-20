# frozen_string_literal: true

require 'spec_helper_acceptance'

if os[:family] == 'redhat'
  describe 'setting alternatives with a `family`' do
    context 'java 8' do
      let(:pp) do
        <<-PP
        package { ['java-1.8.0-openjdk','java-11-openjdk']:
          ensure => installed,
          before => Alternatives['java'],
        }

        alternatives { 'java':
          path => 'java-1.8.0-openjdk.x86_64',
        }
        PP
      end

      it_behaves_like 'an idempotent resource'

      describe command('java -version') do
        its(:stderr) { is_expected.to match %r{1\.8\.0} }
      end
    end

    context 'java 11' do
      let(:pp) do
        <<-PP
        package { ['java-1.8.0-openjdk','java-11-openjdk']:
          ensure => installed,
          before => Alternatives['java'],
        }

        alternatives { 'java':
          path => 'java-11-openjdk.x86_64',
        }
        PP
      end

      it_behaves_like 'an idempotent resource'

      describe command('java -version') do
        its(:stderr) { is_expected.to match %r{11\.0} }
      end
    end
  end
end
