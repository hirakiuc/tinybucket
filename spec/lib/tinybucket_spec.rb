require 'spec_helper'

RSpec.describe Tinybucket do

  describe 'new' do
    let(:options) { { key: 'value' } }

    shared_examples_for 'return client which configured with options' do
      it 'return client instance which configured with options' do
        expect(subject).to be_instance_of(Tinybucket::Client)
        expect(subject.config).to eq(options)
      end
    end

    context 'when options passed' do
      subject { Tinybucket.new(options) }
      it_behaves_like 'return client which configured with options'
    end

    context 'when block given' do
      subject { Tinybucket.new(&block) }
      let(:block) do
        lambda do |config|
          options.each_pair do |key, value|
            config.send("#{key}=", value)
          end
        end
      end
      it_behaves_like 'return client which configured with options'
    end
  end

  describe 'config' do
    subject { Tinybucket.config }
    it { expect(subject).to be_an_instance_of(Tinybucket::Config) }
  end

  describe 'configure' do
    subject(:config) { Tinybucket.config }
    let(:logger) { Logger.new($stdout) }

    it 'can configurable logger' do
      expect(config.logger).to be_nil

      expect do
        Tinybucket.configure do |config|
          config.logger = logger
        end
      end.not_to raise_error

      expect(config.logger).to eq(logger)
    end

    after { Tinybucket.configure { |config| config.logger = nil } }
  end
end
