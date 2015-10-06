require 'spec_helper'

describe 'get_loopback' do
  it { should run.with_params().and_return('1.1.1.1') }
end
