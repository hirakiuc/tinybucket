require 'spec_helper'

RSpec.describe Tinybucket::Model::Hook do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('hook') }

  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:hook_payload)  do
    {
      :url => "https://mywebapp.com/bitbucket/hook",
      :description => "Here's my description",
      :events => ['issue:created', 'issue:updated', 'issue:comment_created'],
      :active => true,
    }
  end

  let(:model) do
    m = Tinybucket::Model::Hook.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug
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
                  Tinybucket::Model::Hook,
                  load_json_fixture('hook')

  describe 'model can reloadable' do
    let(:hook) { Tinybucket::Model::Hook.new({}) }
    before { @model = hook }
    it_behaves_like 'the model is reloadable'
  end

  describe 'hook can be updated' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/hooks/#{model.uuid}" }
    let(:request_method) { :put }
    subject { model.update(hook_payload) }
    it { expect(subject).to be_truthy }
  end

  describe 'hook can be deleted' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/hooks/#{model.uuid}" }
    let(:request_method) { :delete }
    subject { model.destroy }
    it { expect(subject).to be_truthy }
  end

end
