require 'spec_helper'

RSpec.describe Tinybucket do

  describe 'new' do
    subject { Tinybucket.new }
    it { expect(subject).to be_instance_of(Tinybucket::Client) }
  end

  describe 'config' do
    subject { Tinybucket.config }
    it { expect(subject).to be_an_instance_of(Tinybucket::Config) }
  end

  describe 'configure' do
    subject(:config) { Tinybucket.config }
    let(:logger) { Logger.new($stdout) }
    let(:oauth_token) { 'test_oauth_token' }
    let(:oauth_secret) { 'test_oauth_secret' }
    let(:cache_store_options) { { logger: Tinybucket.logger } }

    it 'is configurable' do
      expect(config.logger).to be_nil

      expect do
        Tinybucket.configure do |config|
          config.logger = logger
          config.cache_store_options = cache_store_options
          config.oauth_token = oauth_token
          config.oauth_secret = oauth_secret
        end
      end.not_to raise_error

      expect(config.logger).to eq(logger)
      expect(config.cache_store_options).to eq(cache_store_options)
      expect(config.oauth_token).to eq(oauth_token)
      expect(config.oauth_secret).to eq(oauth_secret)
    end

    after { Tinybucket.instance_variable_set(:@config, nil) }
  end
end
