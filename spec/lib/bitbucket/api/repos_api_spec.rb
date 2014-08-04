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

  describe 'find' do
    let(:repo_owner) { 'test_owner' }
    let(:repo_slug) { 'test_repo' }
    let(:request_path) { nil }

    subject { api.find(repo_owner, repo_slug) }

    before { stub_apiresponse(:get, request_path) if request_path }

    context 'when without repo_owner and repo_slug' do
      let(:repo_owner) { nil }
      let(:repo_slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:repo_owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:repo_slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) { "/repositories/#{repo_owner}/#{repo_slug}" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Repository) }
    end
  end
end
