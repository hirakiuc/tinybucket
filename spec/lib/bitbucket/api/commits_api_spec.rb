require 'spec_helper'

RSpec.describe Bitbucket::Api::CommitsApi do
  include ApiResponseMacros

  let(:request_path) { nil }
  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }
  let(:options) { {} }

  let(:api_config) { {} }
  let(:api) do
    api = Bitbucket::Api::CommitsApi.new(api_config)
    api.repo_owner = owner
    api.repo_slug  = slug
    api
  end

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe 'list' do
    subject { api.list(options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) { "/repositories/#{owner}/#{slug}/commits" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end

  describe 'find' do
    let(:revision) { '1' }
    subject { api.find(revision, options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{revision}"
      end
      it { expect(subject).to be_instance_of(Bitbucket::Models::Commit) }
    end
  end
end
