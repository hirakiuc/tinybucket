require 'spec_helper'

RSpec.describe Tinybucket::Model::Repository do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('repository') }

  let(:request_path) { nil }
  let(:stub_options) { {} }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }
  let(:branch) { "master" }

  let(:model) do
    m = Tinybucket::Model::Repository.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug
    m
  end

  let(:empty_model) do
    m = Tinybucket::Model::Repository.new({})
    m.repo_owner = owner
    m.repo_slug  = slug
    m
  end

  before { stub_apiresponse(:get, request_path, stub_options) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Repository,
                  load_json_fixture('repository')

  describe 'model can reloadable' do
    before { @model = empty_model }
    it_behaves_like 'the model is reloadable'
  end

  describe '#update' do
    let(:request_path) { "/repositories/#{owner}/#{slug}" }
    let(:new_name) { 'New repository name' }
    before { stub_apiresponse(:put, request_path) }
    it { expect(model.name).not_to eq(new_name) }
    subject{ model.update(name: new_name ) }
    it { expect(subject).to be_a(Tinybucket::Model::Repository) }
    it { expect(subject.name).to eq(new_name) }
  end

  describe '#destroy' do
    let(:request_path) { "/repositories/#{owner}/#{slug}" }
    before { stub_apiresponse(:delete, request_path) }
    subject{ model.destroy }
    it { expect(subject).to be_nil }
  end

  describe '#pull_requests' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests"
    end

    subject { model.pull_requests() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::PullRequests) }
  end

  describe '#pull_request' do
    let(:prid) { 1 }

    subject { model.pull_request(prid) }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/#{prid}"
    end
    it 'return the specific pull_request model' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::PullRequest)
      expect(subject.id).to eq(prid)
    end
  end

  describe '#watchers' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/watchers" }
    subject { model.watchers }
    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::Watchers) }
  end

  describe '#forks' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/forks" }
    subject { model.forks }
    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::Forks) }
  end

  describe '#commits' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/commits" }
    subject { model.commits }
    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::Commits) }
  end

  describe '#commit' do
    let(:revision) { '1' }
    let(:request_path) { "/repositories/#{owner}/#{slug}/commit/#{revision}" }
    subject { model.commit(revision) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Commit) }
  end

  describe '#branches' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/branches" }
    subject { model.branches }
    it { expect(subject).to be_an_instance_of(Tinybucket::Resource::Branches) }
  end

  describe '#branch' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/branches/#{branch}" }
    subject { model.branch(branch) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Branch) }
  end

  describe '#branch_restrictions' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/branch-restrictions" }
    subject { model.branch_restrictions }
    it 'return resource model' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::BranchRestrictions)
    end
  end

  describe '#branch_restriction' do
    let(:restriction_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/branch-restrictions/#{restriction_id}"
    end
    subject { model.branch_restriction(restriction_id) }
    it 'return BranchRestriction model' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::BranchRestriction)
    end
  end

  describe '#diff' do
    let(:diff_spec) { '1' }
    let(:request_path) { "/repositories/#{owner}/#{slug}/diff/#{diff_spec}" }
    let(:stub_options) { { content_type: 'text/plain' } }
    subject { model.diff(diff_spec) }
    it { expect(subject).to be_an_instance_of(String) }
  end

  describe '#patch' do
    let(:patch_spec) { '1' }
    let(:request_path) { "/repositories/#{owner}/#{slug}/patch/#{patch_spec}" }
    let(:stub_options) { { content_type: 'text/plain' } }
    subject { model.patch(patch_spec) }
    it { expect(subject).to be_an_instance_of(String) }
  end
end
