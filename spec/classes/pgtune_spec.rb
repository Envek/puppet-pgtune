require 'spec_helper'

describe 'pgtune' do
  let(:facts) do
    {
      memorysize_mb: 490.00,
      osfamily: 'Debian',
      operatingsystem: 'Debian',
      operatingsystemrelease: 'jessie',
    }
  end

  let(:pre_condition) do <<-EOF
    class { 'postgresql::globals':
      version  => '9.4',
    }->
    class { 'postgresql::server': }
    EOF
  end

  context 'with no parameters' do
    it { should contain_postgresql__server__config_entry('work_mem').with('value' => '627kB') }
    it { should contain_postgresql__server__config_entry('max_connections').with('value' => '100') }
  end

  context 'with a custom db type value' do
    let(:params) { { 'db_type' => 'web' } }
    it { should contain_postgresql__server__config_entry('work_mem').with('value' => '627kB') }
    it { should contain_postgresql__server__config_entry('max_connections').with('value' => '200') }
  end

  context 'with a custom max connections value' do
    let(:params) { {'max_connections' => '100' } }
    it { should contain_postgresql__server__config_entry('work_mem').with('value' => '627kB') }
    it { should contain_postgresql__server__config_entry('max_connections').with('value' => '100') }
  end

  context 'with both custom max connections and db type values' do
    let(:params) { { 'max_connections' => '100', 'db_type' => 'web' } }
    it { should contain_postgresql__server__config_entry('work_mem').with('value' => '1254kB') }
    it { should contain_postgresql__server__config_entry('max_connections').with('value' => '100') }
  end

end
