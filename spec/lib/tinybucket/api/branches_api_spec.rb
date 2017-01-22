require 'spec_helper'

RSpec.describe Tinybucket::Api::BranchesApi do
  include ApiResponseMacros

  let(:branch) { "master" }
  let(:request_path) { nil }
  let(:options) { {} }
  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:api) do
    api = Tinybucket::Api::BranchesApi.new
    api.repo_owner = owner
    api.repo_slug  = slug
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

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
      let(:request_path) { "/repositories/#{owner}/#{slug}/refs/branches" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'find' do
    subject { api.find(branch, options) }

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
        "/repositories/#{owner}/#{slug}/refs/branches/#{branch}"
      end
      it { expect(subject).to be_instance_of(Tinybucket::Model::Branch) }
    end
  end
end
