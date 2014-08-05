require 'spec_helper.rb'

RSpec.describe Bitbucket::Api::RepoApi do
  include ApiResponseMacros

  let(:repo_owner) { 'test_owner' }
  let(:repo_slug) { 'test_repo' }
  let(:request_path) { nil }

  let(:api_config) { {} }
  let(:api) do
    api = Bitbucket::Api::RepoApi.new(api_config)
    api.repo_owner = repo_owner
    api.repo_slug  = repo_slug
    api
  end

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe 'find' do
    subject { api.find }

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

  describe 'watchers' do
    subject { api.watchers }

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
      let(:request_path) do
        "/repositories/#{repo_owner}/#{repo_slug}/watchers"
      end
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end

  describe 'forks' do
    subject { api.forks }

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
      let(:request_path) do
        "/repositories/#{repo_owner}/#{repo_slug}/forks"
      end
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end
end
