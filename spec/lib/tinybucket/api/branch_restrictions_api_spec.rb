require 'spec_helper'

RSpec.describe Tinybucket::Api::BranchRestrictionsApi do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:request_path) { nil }

  let(:api_config) { {} }
  let(:api) do
    api = Tinybucket::Api::BranchRestrictionsApi.new(api_config)
    api.repo_owner = owner
    api.repo_slug = slug
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe '#list' do
    subject { api.list }

    context 'without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/branch-restrictions"
      end
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

  describe '#find' do
    let(:restriction_id) { '1' }
    subject { api.find(restriction_id) }

    context 'without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/branch-restrictions/#{restriction_id}"
      end
      it 'return BranchRestriction Model' do
        expect(subject).to be_an_instance_of(Tinybucket::Models::BranchRestriction)
      end
    end
  end
end
