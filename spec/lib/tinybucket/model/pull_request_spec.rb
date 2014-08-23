require 'spec_helper'

RSpec.describe Tinybucket::Model::PullRequest do
  include ApiResponseMacros

  let(:model_json) { JSON.load(File.read('spec/fixtures/pull_request.json')) }

  let(:request_method) { :get }
  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:model) do
    repo = Tinybucket::Model::Repository.new({})
    repo.owner = owner
    repo.full_name = "#{owner}/#{slug}"

    pr = Tinybucket::Model::PullRequest.new(model_json)
    pr.repository = repo
    pr.id = 1

    pr
  end

  before { stub_apiresponse(request_method, request_path) if request_path }

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
