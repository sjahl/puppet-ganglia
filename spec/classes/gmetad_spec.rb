#!/usr/bin/env ruby

require 'spec_helper'

describe 'ganglia::gmetad' do
  let(:params) do {:clustername => "footest",
    :gridname => "MegaGrid",
    :trustedhosts => "ganglia-server.domain"} 
  end

  it { should contain_package('ganglia-gmetad').with_ensure('installed') }

  it do should contain_file('/etc/ganglia/gmetad.conf').with({
    'content' => /MegaGrid/,
    'content' => /ganglia-server.domain/,
    }) 
  end

  it { should contain_service('gmetad').with_ensure('running') }
end