require 'spec_helper'

RSpec.describe Tinybucket::Models::Repository do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:model_json) { JSON.load(File.read('spec/fixtures/repository.json')) }
  let(:model) do
    m = Tinybucket::Models::Repository.new(model_json)
    m.owner = owner
    m.full_name = "#{owner}/#{slug}"

    m
  end
  let(:request_path) { nil }
  let(:stub_options) { {} }

  before { stub_apiresponse(:get, request_path, stub_options) if request_path }

  describe '#pull_requests' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests"
    end

    subject { model.pull_requests() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
  end

  describe '#pull_request' do
    let(:prid) { 1 }
    let(:request_path) { "/repositories/#{owner}/#{slug}/pullrequests/#{prid}" }
    subject { model.pull_request(prid) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::PullRequest) }
  end

  describe '#watchers' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/watchers" }
    subject { model.watchers }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
  end

  describe '#forks' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/forks" }
    subject { model.forks }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
  end

  describe '#commits' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/commits" }
    subject { model.commits }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
  end

  describe '#commit' do
    let(:revision) { '1' }
    let(:request_path) { "/repositories/#{owner}/#{slug}/commit/#{revision}" }
    subject { model.commit(revision) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Commit) }
  end

  describe '#branch_restrictions' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/branch-restrictions" }
    subject { model.branch_restrictions }
    it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
  end

  describe '#branch_restriction' do
    let(:restriction_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/branch-restrictions/#{restriction_id}"
    end
    subject { model.branch_restriction(restriction_id) }
    it 'return BranchRestriction model' do
      expect(subject).to be_an_instance_of(Tinybucket::Models::BranchRestriction)
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

  describe '#repo_owner' do
    subject { model.repo_owner }

    context 'when owner is nil' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect(subject).to be_nil }
    end

    context 'when owner is hash' do
      let(:owner) { nil }
      let(:slug) { nil }

      before { model.owner = owner_hash }

      context 'the hash does not contain \'username\' key' do
        let(:owner_hash) { {} }
        it { expect(subject).to be_nil }
      end

      context 'the hash contains \'username\' key' do
        let(:owner) { 'test_owner' }
        let(:owner_hash) { { 'username' => owner } }
        it { expect(subject).to eq(owner) }
      end
    end

    context 'when owner is a string' do
      let(:owner) { 'test_owner' }
      let(:slug) { nil }

      before { model.owner = owner }
      it { expect(subject).to eq(owner) }
    end
  end

  describe '#repo_slug' do
    subject { model.repo_slug }

    context 'when full_name is blank' do
      before { model.full_name = nil }
      it { expect(subject).to be_nil }
    end

    context 'when full_name is invalid format' do
      before { model.full_name = 'invalid full_name' }
      it { expect(subject).to be_nil }
    end

    context 'when full_name is valid format' do
      before { model.full_name = "#{owner}/#{slug}" }
      it { expect(subject).to eq(slug) }
    end
  end
end
