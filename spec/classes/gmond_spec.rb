#!/usr/bin/env ruby

require 'spec_helper'

describe 'ganglia::gmond' do
  let(:params) { { :clustername => "footest", :headnode => "foo-node.domain" } }

  it { should contain_package('ganglia-gmond').with_ensure('installed') }

  it { should contain_file('/etc/ganglia/gmond.conf').with_content(/foo-node\.domain/) }

  it { should contain_service('gmond').with_ensure('running') }
end