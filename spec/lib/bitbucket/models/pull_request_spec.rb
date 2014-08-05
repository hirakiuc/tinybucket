require 'spec_helper'

RSpec.describe Bitbucket::Models::PullRequest do
  include ApiResponseMacros

  let(:model_json) { JSON.load(File.read('spec/fixtures/pull_request.json')) }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  describe 'commits' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/1/commits"
    end

    let(:model) do
      repo = Bitbucket::Models::Repository.new({})
      repo.owner = owner
      repo.full_name = "#{owner}/#{slug}"

      pr = Bitbucket::Models::PullRequest.new(model_json)
      pr.repository = repo
      pr.id = 1

      pr
    end

    subject { model.commits() }

    before { stub_apiresponse(:get, request_path) }

    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end
end
