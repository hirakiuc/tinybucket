require 'spec_helper'

RSpec.describe Tinybucket::Model::Team do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('team') }

  let(:request_path) { nil }

  let(:teamname) { 'test_team' }

  let(:model) do
    Tinybucket::Model::Team.new(model_json).tap do |m|
      m.username = teamname
    end
  end

  before { stub_apiresponse(:get, request_path) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Team,
                  load_json_fixture('team')

  describe 'model can reloadable' do
    let(:team) do
      m = Tinybucket::Model::Team.new({})
      m.username = teamname
      m
    end
    before { @model = team }
    it_behaves_like 'the model is reloadable'
  end

  describe '#members' do
    let(:request_path) { "/teams/#{teamname}/members" }
    subject { model.members }
    it 'return resource' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::Team::Members)
    end
  end

  describe '#followers' do
    let(:request_path) { "/teams/#{teamname}/followers" }
    subject { model.followers() }
    it 'return resource' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::Team::Followers)
    end
  end

  describe '#following' do
    let(:request_path) { "/teams/#{teamname}/following" }
    subject { model.following }
    it 'return resource' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::Team::Following)
    end
  end

  describe '#repos' do
    let(:request_path) { "/teams/#{teamname}/repositories" }
    subject { model.repos }
    it 'return resource' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::Team::Repos)
    end
  end

  describe '#projects' do
    let(:request_path) { "/teams/#{teamname}/projects/" }
    subject { model.projects }
    it 'return resource' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::Projects)
    end
  end

  describe '#project' do
    let(:project_key) { 'myprj' }
    let(:request_path) { "/teams/#{teamname}/projects/#{project_key}" }
    subject { model.project(project_key) }
    it 'return Project model' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Model::Project)
    end
  end
end
