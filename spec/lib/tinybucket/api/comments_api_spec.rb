require 'spec_helper'

RSpec.describe Tinybucket::Api::CommentsApi do
  include ApiResponseMacros

  let(:request_path) { nil }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:options) { {} }

  let(:commit_hash) { '1' }
  let(:commit) do
    m = Tinybucket::Model::Commit.new({})
    m.repo_owner = owner
    m.repo_slug  = slug
    m.hash = commit_hash
    m
  end

  let(:pullreq_id) { '1' }
  let(:pullreq) do
    m = Tinybucket::Model::PullRequest.new({})
    m.repo_owner = owner
    m.repo_slug  = slug
    m.id = pullreq_id
    m
  end

  let(:commented_to) { nil }
  let(:api) do
    api = Tinybucket::Api::CommentsApi.new
    api.repo_owner = owner
    api.repo_slug = slug
    api.commented_to = commented_to if commented_to.present?
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe '#list' do
    subject { api.list(options) }
    let(:commented_to) { commit }

    context 'when without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without commented_to' do
      let(:commented_to) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with unknown commented_to' do
      let(:commented_to) { {} }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when commented_to is commit' do
      let(:commented_to) { commit }
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{commit_hash}/comments"
      end
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end

    context 'when commented_to is pullreq' do
      let(:commented_to) { pullreq }
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/#{pullreq_id}/comments"
      end
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe '#find' do
    subject { api.find(comment_id, options) }
    let(:commented_to) { commit }
    let(:comment_id) { '1' }

    context 'when without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without commented_to' do
      let(:commented_to) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with unknown commented_to' do
      let(:commented_to) { {} }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when commented_to is commit' do
      let(:commented_to) { commit }
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{commit_hash}" \
          "/comments/#{comment_id}"
      end
      it 'return Comment model' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::Comment)
        expect(subject.commented_to).to eq(commit)
      end
    end

    context 'when commented_to is pull_request' do
      let(:commented_to) { pullreq }
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/#{pullreq_id}" \
          "/comments/#{comment_id}"
      end
      it 'return Comment model' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::Comment)
        expect(subject.commented_to).to eq(pullreq)
      end
    end
  end
end
