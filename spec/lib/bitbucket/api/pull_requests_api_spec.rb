require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::PullRequestsApi do
  include ApiResponseMacros

  let(:api_config){ {} }
  let(:api){ Bitbucket::Api::PullRequestsApi.new(api_config) }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::PullRequestsApi) }

  describe 'list' do
    let(:request_path){ nil }
    let(:options){ {} }
    subject{ api.list(options) }

    before do
      api.repo_owner = repo_owner
      api.repo_slug  = repo_slug
      stub_apiresponse(:get, request_path) if request_path.present?
    end

    context 'without repo_owner and repo_slug' do
      let(:repo_owner){ nil }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_owner' do
      let(:repo_owner){ nil }
      let(:repo_slug){ 'test_repo' }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_slug' do
      let(:repo_owner){ 'test_owner' }
      let(:repo_slug){ nil }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context 'with repo_owner and repo_slug' do
      let(:repo_owner){ 'test_owner' }
      let(:repo_slug){ 'test_repo' }
      let(:request_path){ '/repositories/test_owner/test_repo/pullrequests' }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end

    context 'when request with state' do
      let(:repo_owner){ 'test_owner' }
      let(:repo_slug){ 'test_repo' }
      let(:options){ { state: state } }
      let(:request_path){ "/repositories/test_owner/test_repo/pullrequests?state=#{state}" }

      context 'when state is OPEN' do
        let(:state){ 'OPEN' }
        it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
      end

      context 'when state is DECLINED' do
        let(:state){ 'DECLINED' }
        it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
      end

      context 'when state is MERGED' do
        let(:state){ 'MERGED' }
        it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
      end
    end

  end
end
