require 'spec_helper.rb'

RSpec.describe Tinybucket::Connection do

  class MockApi
    include Tinybucket::Connection

    def config(key)
      nil
    end
  end

  let(:mock_api){ MockApi.new }

  describe 'clear_cache' do
    pending 'TODO: this method is required ?'
  end

  describe 'caching?' do
    pending 'TODO: this method is required ?'
  end

  describe 'connection(options, parser)' do
    subject{ mock_api.connection }

    context 'when no params are given ' do
      it { expect(subject).to be_instance_of(Faraday::Connection) }
    end
  end
end
