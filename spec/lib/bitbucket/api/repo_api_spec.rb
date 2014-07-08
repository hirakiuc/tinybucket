require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::RepoApi do
  include ApiResponseMacros

  let(:api_config){ {} }
  let(:api){ Bitbucket::Api::RepoApi.new(api_config) }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  let(:options){ {} }

  let(:owner){ nil }
  let(:repo_slug){ nil }
  let(:request_path){ nil }
  before do
    api.owner = owner
    api.repo_slug = repo_slug
    stub_apiresponse(:get, request_path) if request_path.present?
  end

  describe 'find' do
    subject{ api.find(options) }

    context 'when without owner and repo_slug' do
      let(:owner){ nil }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without owner' do
      let(:owner){ nil }
      let(:repo_slut){ 'test_repo' }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:owner){ 'test_owner' }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when with owner and repo_slug' do
      let(:owner){ 'test_owner' }
      let(:repo_slug){ 'test_repo' }
      let(:request_path){ '/repositories/test_owner/test_repo' }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Repository) }
    end
  end

  describe 'path_to_find' do
    subject{ api.send(:path_to_find) }

    context 'when without owner and repo_slug' do
      let(:owner){ nil }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without owner' do
      let(:owner){ nil }
      let(:repo_slug){ 'test_repo' }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:owner){ 'test_owner' }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when with owner and repo_slug' do
      let(:owner){ 'test_owner' }
      let(:repo_slug){ 'test_repo' }
      it { expect(subject).to eq('/repositories/test_owner/test_repo') }
    end
  end
end
