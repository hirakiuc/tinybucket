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

  describe 'configure_auth' do
    subject(:handlers) { mock_api.connection.builder.handlers }

    context 'with Tinybucket.config.access_token' do
      before do
        allow_any_instance_of(Tinybucket::Config).to \
          receive(:access_token).and_return('test token')
      end

      it 'should use oauth2 middleware' do
        expect(handlers).to include(FaradayMiddleware::OAuth2)
        expect(handlers).not_to include(FaradayMiddleware::OAuth)
      end
    end

    context 'without Tinybucket.config.access_token' do
      before do
        allow_any_instance_of(Tinybucket::Config).to \
          receive(:access_token).and_return(nil)
      end

      it 'should use oauth middleware' do
        expect(handlers).not_to include(FaradayMiddleware::OAuth2)
        expect(handlers).to include(FaradayMiddleware::OAuth)
      end
    end
  end
end
