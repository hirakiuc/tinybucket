require 'spec_helper'

RSpec.describe Tinybucket::Model::Commit do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('commit') }

  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:model) do
    m = Tinybucket::Model::Commit.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug
    m.hash = '1'

    m
  end

  before { stub_apiresponse(:get, request_path) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Commit,
                  load_json_fixture('commit')

  describe 'model can reloadable' do
    let(:commit) do
      m = Tinybucket::Model::Commit.new({})
      m.repo_owner = owner
      m.repo_slug = slug
      m.hash = '1'
      m
    end
    before { @model = commit }
    it_behaves_like 'the model is reloadable'
  end

  describe '#comments' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/comments"
    end
    subject { model.comments }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe '#comment' do
    let(:comment_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/comments/#{comment_id}"
    end
    subject { model.comment(comment_id) }
    it 'return Comment' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::Comment)
    end
  end

  describe '#approve' do
    pending 'TODO implement method'
  end

  describe '#unapprove' do
    pending 'TODO implement method'
  end
end
