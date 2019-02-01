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

  describe 'default_options' do 
    subject{ mock_api.connection }

    it 'should set a Encoder to the connection' do 
      expect(subject.options[:params_encoder]).not_to be_nil
    end

    it 'should include the ApiParamsEncoder as default params_encoder' do
      expect(subject.options[:params_encoder]).to be(Tinybucket::Encoder::ApiParamsEncoder)
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


# def default_options(_options)
#   {
#     headers: {
#       USER_AGENT: Tinybucket.config.user_agent || DEFAULT_USER_AGENT
#     },
#     ssl: { verify: false },
#     url: 'https://api.bitbucket.org/2.0'.freeze,
#     request: {
#       params_encoder: Tinybucket::Encoder::ApiParamsEncoder
#     }
#   }
# end