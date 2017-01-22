require 'spec_helper'

RSpec.describe Tinybucket::Resource::Commit::BuildStatuses do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:revision) { '1' }
  let(:commit) do
    Tinybucket::Model::Commit.new({}).tap do |m|
      m.hash = revision
      m.repo_owner = owner
      m.repo_slug = slug
    end
  end

  let(:options) { {} }
  let(:resource) do
    Tinybucket::Resource::Commit::BuildStatuses.new(commit, options)
  end

  let(:status_key) { 'test_status' }

  describe '#find' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses/build/#{status_key}"
    end
    subject { resource.find(status_key) }
    before { stub_apiresponse(:get, request_path) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end

  describe '#create' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses/build"
    end
    let(:params) do
      {
        state: 'INPROGRESS',
        name: 'test_repo test #10',
        url: 'https://example.com/path/to/build/info',
        description: 'Changes by test_owner'
      }
    end

    before { stub_apiresponse(:post, request_path) }
    subject { resource.create(status_key, params) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/statuses"
    end
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::BuildStatus)
        end
      end
    end
  end
end
