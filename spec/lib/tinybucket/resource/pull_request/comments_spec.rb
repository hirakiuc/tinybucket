require 'spec_helper'

RSpec.describe Tinybucket::Resource::PullRequest::Comments do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:pullrequest_id) { '1' }
  let(:pull_request) do
    Tinybucket::Model::PullRequest.new({}).tap do |m|
      m.id = pullrequest_id
      m.repo_owner = owner
      m.repo_slug = slug
    end
  end

  let(:options) { {} }
  let(:resource) do
    Tinybucket::Resource::PullRequest::Comments.new(pull_request, options)
  end

  describe 'Enumerable Methods' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/#{pullrequest_id}/comments"
    end
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Comment)
        end
      end
    end
  end
end
