require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::RepoApi do
  include ApiResponseMacros

  let(:api_config){ {} }
  let(:api){ Bitbucket::Api::RepoApi.new(api_config) }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  describe 'find' do
    let(:options){ {} }
    subject{ api.find(options) }
    before do
      api.owner = owner
      api.repo_slug = repo_slug
    end

    context 'when without owner and repo_slug' do
      let(:owner){ nil }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without owner' do
      pending
    end

    context 'when without repo_slug' do
      pending
    end

    context 'when with owner and repo_slug' do
      pending
    end
  end

  describe 'path_to_find' do
    context 'when without owner and repo_slug' do
      pending
    end

    context 'when without owner' do
      pending
    end

    context 'when without repo_slug' do
      pending
    end

    context 'when with owner and repo_slug' do
      pending
    end
  end
end
