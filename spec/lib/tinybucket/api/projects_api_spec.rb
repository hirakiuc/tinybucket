require 'spec_helper'

RSpec.describe Tinybucket::Api::ProjectsApi do
  include ApiResponseMacros

  let(:api) { Tinybucket::Api::ProjectsApi.new }
  let(:owner) { 'test_team' }
  let(:request_path) { nil }
  before do
    api.owner = owner
    stub_apiresponse(:get, request_path) if request_path
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'list' do
    subject { api.list() }
    let(:request_path) { '/teams/test_team/projects/' }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'find' do
    let(:project_key) { 'myprj' }
    subject { api.find(project_key) }

    let(:request_path) { "/teams/test_team/projects/#{project_key}" }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end
end
