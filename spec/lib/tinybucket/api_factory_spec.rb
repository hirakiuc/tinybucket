require 'spec_helper'

RSpec.describe Tinybucket::ApiFactory do

  describe 'create_instance' do
    let(:klass_name) { 'PullRequests' }
    let(:config) { {} }
    let(:options) { {} }

    subject do
      Tinybucket::ApiFactory.create_instance(klass_name, config, options)
    end

    context 'with valid klass_name' do
      it { expect(subject).to be_a_kind_of(Tinybucket::Api::BaseApi) }
    end

    context 'with invalid klass_name' do
      let(:klass_name) { 'Invalid Klass Name' }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
