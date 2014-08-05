require 'spec_helper'

RSpec.describe Bitbucket::Models::Repository do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:model_json) { JSON.load(File.read('spec/fixtures/repository.json')) }
  let(:model) do
    m = Bitbucket::Models::Repository.new(model_json)
    m.owner = owner
    m.full_name = "#{owner}/#{slug}"

    m
  end
  let(:request_path) { nil }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe 'pull_requests' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests"
    end

    subject { model.pull_requests() }

    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end

  describe 'pull_request' do
    let(:prid) { 1 }
    let(:request_path) { "/repositories/#{owner}/#{slug}/pullrequests/#{prid}" }
    subject { model.pull_request(prid) }
    it { expect(subject).to be_an_instance_of(Bitbucket::Models::PullRequest) }
  end

  describe '#repo_owner' do
    pending 'TODO add specs'
  end

  describe '#repo_slug' do
    pending 'TODO add specs'
  end
end
