require 'spec_helper'

RSpec.describe Tinybucket::Model::Team do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('team') }

  let(:request_path) { nil }

  let(:teamname) { 'test_team' }

  let(:model) do
    m = Tinybucket::Model::Team.new(model_json)
    m.username = teamname
    m
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
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe '#followers' do
    let(:request_path) { "/teams/#{teamname}/followers" }
    subject { model.followers() }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe '#following' do
    let(:request_path) { "/teams/#{teamname}/following" }
    subject { model.following }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe '#repos' do
    let(:request_path) { "/teams/#{teamname}/repositories" }
    subject { model.repos }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end
end
