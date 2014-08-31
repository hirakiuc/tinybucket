require 'spec_helper'

RSpec.describe Tinybucket::Model::Team do
  include ApiResponseMacros
  include ModelMacros

  let(:teamname) { 'test_team' }

  let(:model_json) { JSON.load(File.read('spec/fixtures/profile.json')) }
  let(:model) do
    m = Tinybucket::Model::Team.new(model_json)
    m.username = teamname
    m
  end

  let(:request_path) { nil }

  before { stub_apiresponse(:get, request_path) if request_path }

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
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe '#followers' do
    let(:request_path) { "/teams/#{teamname}/followers" }
    subject { model.followers() }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe '#following' do
    let(:request_path) { "/teams/#{teamname}/following" }
    subject { model.following }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe '#repos' do
    let(:request_path) { "/teams/#{teamname}/repositories" }
    subject { model.repos }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end
end
