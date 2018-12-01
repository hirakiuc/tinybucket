require 'spec_helper'

RSpec.describe Tinybucket::Model::Tag do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('tag') }

  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:model) do
    m = Tinybucket::Model::Tag.new(model_json)
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
                  Tinybucket::Model::Tag,
                  load_json_fixture('tag')

  describe 'model can reloadable' do
    let(:tag) { Tinybucket::Model::Tag.new({}) }
    before { @model = tag }
    it_behaves_like 'the model is reloadable'
  end

  describe 'commits' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/commits/#{model.name}" }
    subject { model.commits }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
    it { expect(subject).to all( be_an_instance_of Tinybucket::Model::Commit) }
  end
end
