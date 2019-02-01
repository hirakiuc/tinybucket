require 'spec_helper.rb'

RSpec.describe Tinybucket::Api::RepoApi do
  include ApiResponseMacros

  let(:repo_owner) { 'test_owner' }
  let(:repo_slug) { 'test_repo' }
  let(:request_path) { nil }

  let(:api) do
    api = Tinybucket::Api::RepoApi.new
    api.repo_owner = repo_owner
    api.repo_slug  = repo_slug
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe '#put' do 
    let(:request_path) { "/repositories/#{repo_owner}/#{repo_slug}" }
    let(:params){ {} }
    before { stub_apiresponse(:put, request_path) } 
    subject { api.put(params) }
    it { expect(subject).to be_a(Tinybucket::Model::Repository) }
  end

  describe '#delete' do
    let(:request_path) { "/repositories/#{repo_owner}/#{repo_slug}" }
    subject{ api.delete }
    before { stub_apiresponse(:delete, request_path) } 
    it { expect(subject).to be_nil }
  end


  describe '#watchers' do
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
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe '#forks' do
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
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end
end
