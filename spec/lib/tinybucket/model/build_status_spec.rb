require 'spec_helper'

RSpec.describe Tinybucket::Model::BuildStatus do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('build_status') }

  let(:request_method) { :get }
  let(:request_path) { nil }
  let(:stub_options) { nil }

  let(:commit_hash) { '1' }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:model) do
    Tinybucket::Model::BuildStatus.new(model_json).tap do |m|
      m.repo_owner = owner
      m.repo_slug = slug
      m.revision = commit_hash
    end
  end

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::BuildStatus,
                  load_json_fixture('build_status')

  describe 'model can reloadable' do
    let(:build_status) do
      Tinybucket::Model::BuildStatus.new({}).tap do |m|
        m.repo_owner = owner
        m.repo_slug = slug
        m.revision = commit_hash
      end
    end

    before { @model = build_status }
    it_behaves_like 'the model is reloadable'
  end

  describe '#update' do
    let(:status_key) { 'test_status' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/1/statuses/build/#{status_key}"
    end
    let(:params) do
      {
        state: 'SUCCESSFUL',
        name: 'test_repo test #10',
        url: 'https://example.com/path/to/build/info',
        description: 'Changes by test_owner'
      }
    end
    let(:request_method) { :put }

    subject { model.update(params) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BuildStatus) }
  end
end
