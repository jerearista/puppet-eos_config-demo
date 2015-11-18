require 'spec_helper'

describe 'eos_config::vlans' do
  let :facts do
  {
    :operatingsystem => 'AristaEOS',
  }
  end

  #let(:params) { {:purge => 'false'} }

  it { should compile }
  it { is_expected.to create_class('eos_config::vlans') }

  context 'with basic parameters' do
    #it { should contain_class('eos_vlan') }

    #it { should have_resource_count(5) }
    it { should have_eos_vlan_resource_count(4) }

    it { is_expected.to contain_eos_vlan('1') }
    it { is_expected.to contain_eos_vlan('9') }
    it { is_expected.to contain_eos_vlan('100') }
    it { is_expected.to contain_eos_vlan('101') }
  end

  context 'with purge => true' do
    let(:params) { {:purge => 'true'} }

    #it { should contain_class('eos_vlan') }

    #it { should have_resource_count(5) }
    it { should have_eos_vlan_resource_count(4) }


    it { is_expected.to contain_eos_vlan('1') }
    it { is_expected.to contain_eos_vlan('9') }
    it { is_expected.to contain_eos_vlan('100').with(
      #:ensure => 'present',
      :vlan_name => 'TestVlan_100',
      :enable => false,
      #:purge => 'true',
    ) }
    it { is_expected.to contain_eos_vlan('101').with(
      #:ensure => 'present',
      :vlan_name => 'TEST_VLAN_101',
      #:purge => 'true',
    ) }
    #it { is_expected.to contain_eos_vlan().with(
    #  :purge => 'true',
    #) }
  end
end
