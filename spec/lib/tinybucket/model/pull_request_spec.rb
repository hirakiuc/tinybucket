require 'spec_helper'

RSpec.describe Tinybucket::Model::PullRequest do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('pull_request') }

  let(:request_method) { :get }
  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:model) do
    pr = Tinybucket::Model::PullRequest.new(model_json)
    pr.repo_owner = owner
    pr.repo_slug  = slug
    pr.id = 1

    pr
  end

  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::PullRequest,
                  load_json_fixture('pull_request')

  describe 'model can reloadable' do
    let(:pr) do
      m = Tinybucket::Model::PullRequest.new({})
      m.repo_owner = owner
      m.repo_slug = slug
      m.id = 1
      m
    end
    before { @model = pr }
    it_behaves_like 'the model is reloadable'
  end

  describe '#create' do
    pending 'TODO implement method'
  end

  describe '#update' do
    pending 'TODO implement method'
  end

  describe 'approve' do
    let(:request_method) { :post }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/approve"
    end

    subject { model.approve }

    it { expect(subject).to be_truthy }
  end

  describe 'unapprove' do
    let(:request_method) { :delete }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/approve"
    end

    subject { model.unapprove }

    it { expect(subject).to be_truthy }
  end

  describe 'decline' do
    let(:request_method) { :post }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/decline"
    end

    subject { model.decline }

    it { expect(subject).to be_truthy }
  end

  describe 'commits' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/commits"
    end

    subject { model.commits() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::PullRequest::Commits) }
  end

  describe 'activities' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/activity"
    end

    subject { model.activities() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::PullRequest::Activities) }
  end

  describe 'diffstat' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/diffstat"
    end

    subject { model.diffstats() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::PullRequest::Diffstats) }
  end

  describe 'comments' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/comments"
    end

    subject { model.comments }
    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::PullRequest::Comments) }
  end

  describe 'comment' do
    let(:comment_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/comments/#{comment_id}"
    end
    subject { model.comment(comment_id) }

    it 'return the comment' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::Comment)
      expect(subject.commented_to).to eq(model)
    end
  end

  describe 'diff' do
    let(:stub_options) { { content_type: 'plain/text' } }
    subject { model.diff }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/diff"
    end
    it { expect(subject).to be_instance_of(String) }
  end

  describe 'merge' do
    let(:request_method) { :post }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/merge"
    end

    subject { model.merge }

    it { expect(subject).to be_truthy }
  end
end
