require 'spec_helper'

RSpec.describe Tinybucket::Model::Commit do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:repo) do
    json = JSON.load(File.read('spec/fixtures/repository.json'))
    m = Tinybucket::Model::Repository.new(json)
    m.owner = owner
    m.full_name = "#{owner}/#{slug}"

    m
  end

  let(:model) do
    json = JSON.load(File.read('spec/fixtures/commit.json'))
    m = Tinybucket::Model::Commit.new(json)
    m.repository = repo
    m.hash = '1'

    m
  end

  let(:request_path) { nil }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe '#comments' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/comments"
    end
    subject { model.comments }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe '#comment' do
    let(:comment_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/comments/#{comment_id}"
    end
    subject { model.comment(comment_id) }
    it 'return CommitComment' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::CommitComment)
    end
  end
end
