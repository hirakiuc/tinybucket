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

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

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
    let(:request_method) { :post }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/approve"
    end

    subject { model.approve }

    it { expect(subject).to be_truthy }
  end

  describe '#unapprove' do
    let(:request_method) { :delete }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/approve"
    end
    let(:stub_options) { { status_code: 204, message: '' } }

    subject { model.unapprove }

    it { expect(subject).to be_truthy }
  end
end
