require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::ReposApi do
  include ApiResponseMacros

  let(:api_config) { {} }
  let(:api) { Bitbucket::Api::ReposApi.new(api_config) }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  describe 'list' do
    subject { api.list(options) }

    before { stub_apiresponse(:get, request_path) }

    context 'without owner' do
      let(:options) { {} }
      let(:request_path) { '/repositories' }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end

    context 'with owner' do
      let(:options) { { owner: 'test_owner' } }
      let(:request_path) { '/repositories/test_owner' }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end
end
