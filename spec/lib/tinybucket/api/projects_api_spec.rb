require 'spec_helper'

RSpec.describe Tinybucket::Api::ProjectsApi do
  include ApiResponseMacros

  let(:owner) { 'test_team' }
  let(:options) { {} }
  let(:api) do
    Tinybucket::Api::ProjectsApi.new.tap do |api|
      api.owner = owner
    end
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'list' do
    let(:request_path) { '/teams/test_team/projects/' }
    before { stub_apiresponse(:get, request_path) }
    subject { api.list() }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'find' do
    let(:project_key) { 'myprj' }
    let(:request_path) { "/teams/test_team/projects/#{project_key}" }
    before { stub_apiresponse(:get, request_path) }
    subject { api.find(project_key) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end

  describe 'post' do
    let(:request_path) { '/teams/test_team/projects/' }
    let(:options) { { key: 'myprj', name: 'My project' } }
    before { stub_apiresponse(:post, request_path) }
    subject { api.post(options) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end

  describe 'put' do
    let(:project_key) { 'myprj' }
    let(:request_path) { "/teams/test_team/projects/#{project_key}" }
    let(:options) { { name: 'New project name' } }
    before { stub_apiresponse(:put, request_path) }
    subject { api.put(project_key, options) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end

  describe 'delete' do 
    let(:project_key) { 'myprj' }
    let(:request_path) { "/teams/test_team/projects/#{project_key}" }
    before { stub_apiresponse(:delete, request_path) }
    subject { api.delete(project_key) }
    it { expect(subject).to be_nil }
  end
end