require 'spec_helper'

RSpec.describe Tinybucket::Api::CommitCommentsApi do
  include ApiResponseMacros

  let(:request_path) { nil }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:options) { {} }

  let(:commit_hash) { '1' }
  let(:commit) do
    mock = double('Commit')
    allow(mock).to receive(:hash).and_return(commit_hash)
    mock
  end

  let(:api_config) { {} }
  let(:api) do
    api = Tinybucket::Api::CommitCommentsApi.new(api_config)
    api.repo_owner = owner
    api.repo_slug = slug
    api.commit = commit if commit.present?
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe '#list' do
    subject { api.list(options) }

    context 'when without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without commit' do
      let(:commit) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with owner/slug/commit' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{commit_hash}/comments"
      end
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

  describe '#find' do
    subject { api.find(comment_id, options) }
    let(:comment_id) { '1' }

    context 'when without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without commit' do
      let(:commit) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when owner and slug, commit' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{commit_hash}" \
          + "/comments/#{comment_id}"
      end
      it 'return CommitComment model' do
        expect(subject).to be_an_instance_of(Tinybucket::Models::CommitComment)
      end
    end
  end
end
