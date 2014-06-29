require 'spec_helper'

RSpec.describe Bitbucket do

  describe 'new' do
    let(:options){ { key: 'value' } }

    shared_examples_for 'return client instance which configured with options' do
      it 'return client instance which configured with options' do
        expect(subject).to be_instance_of(Bitbucket::Client)
        expect(subject.config).to eq(options)
      end
    end

    context 'when options passed' do
      subject{ Bitbucket.new(options) }
      it_behaves_like 'return client instance which configured with options'
    end

    context 'when block given' do
      subject{ Bitbucket.new(&block) }
      let(:block) do
        ->(config) {
          options.each_pair do |key, value|
            config.send("#{key}=", value)
          end
        }
      end
      it_behaves_like 'return client instance which configured with options'
    end
  end
end
