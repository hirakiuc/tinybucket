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
end
