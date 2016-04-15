require 'spec_helper'

RSpec.describe Tinybucket::Resource::PullRequests do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::PullRequests.new(repo, options) }

  describe '#create' do
    let(:params) { {} }
    subject { resource.create(params) }
    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  describe '#find' do
    let(:pullrequest_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests/#{pullrequest_id}"
    end
    before { stub_apiresponse(:get, request_path) }
    subject { resource.find(pullrequest_id) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::PullRequest) }
  end

  describe '#activities' do
    let(:params) { {} }
    subject { resource.activities(params) }
    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/pullrequests"
    end
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::PullRequest)
        end
      end
    end
  end
end
