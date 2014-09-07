require 'spec_helper'

RSpec.describe Tinybucket::Model::PullRequest do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { JSON.load(File.read('spec/fixtures/pull_request.json')) }

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

  before { stub_apiresponse(request_method, request_path) if request_path }

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

  describe 'commits' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/commits"
    end

    subject { model.commits() }

    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end
end
