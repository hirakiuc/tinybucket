require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::PullRequestApi do
  include ApiResponseMacros

  let(:api_config){ {} }
  let(:api){ Bitbucket::Api::PullRequestApi.new(api_config) }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  let(:options){ {} }

  let(:repo_owner){ 'test_owner' }
  let(:repo_slug){ 'test_repo' }
  let(:request_path){ nil }

  before do
    api.repo_owner = repo_owner
    api.repo_slug = repo_slug
    stub_apiresponse(:get, request_path) if request_path.present?
  end

  describe 'find' do
    let(:pr_id){ 1 }
    subject{ api.find(pr_id, options) }

    context 'when without repo_owner and repo_slug' do
      let(:repo_owner){ nil }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:repo_owner){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path){ "/repositories/#{repo_owner}/#{repo_slug}/#{pr_id}" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::PullRequest) }
    end
  end
end
