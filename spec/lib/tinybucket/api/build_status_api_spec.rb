require 'spec_helper'

RSpec.describe Tinybucket::Api::BuildStatusApi do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:revision) { '1' }
  let(:status_key) { 'test_status' }
  let(:options) { {} }

  let(:api) do
    Tinybucket::Api::BuildStatusApi.new.tap do |api|
      api.repo_owner = owner
      api.repo_slug = slug
      api.revision = revision
    end
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'list' do
    subject { api.list(options) }

    context 'with owner and slug' do
      let(:request_path) { "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses" }
      before { stub_apiresponse(:get, request_path) }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe '#find' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses/build/#{status_key}"
    end
    subject { api.find(revision, status_key) }
    before { stub_apiresponse(:get, request_path) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end

  describe '#post' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses/build"
    end
    let(:params) do
      {
        state: 'INPROGRESS',
        name: 'test_repo test #10',
        url: 'https://example.com/path/to/build/info',
        description: 'Changes by test_owner'
      }
    end

    subject { api.post(revision, status_key, params) }
    before { stub_apiresponse(:post, request_path) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end

  describe '#put' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses/build/#{status_key}"
    end
    let(:params) do
      {
        state: 'SUCCESSFUL',
        name: 'test_repo test #10',
        url: 'https://example.com/path/to/build/info',
        description: 'Changes by test_owner'
      }
    end

    subject { api.put(revision, status_key, params) }
    before { stub_apiresponse(:put, request_path) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end
end
