require 'spec_helper'

RSpec.describe Tinybucket::Model::Profile do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('profile') }

  let(:request_path) { nil }

  let(:username) { 'test_owner' }

  let(:model) do
    m = Tinybucket::Model::Profile.new(model_json)
    m.username = username
    m
  end

  before { stub_apiresponse(:get, request_path) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Profile,
                  load_json_fixture('profile')

  describe 'model can reloadable' do
    let(:profile) do
      m = Tinybucket::Model::Profile.new({})
      m.username = username
      m
    end
    before { @model = profile }
    it_behaves_like 'the model is reloadable'
  end

  describe 'followers' do
    let(:request_path) { "/users/#{username}/followers" }
    subject { model.followers() }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe 'following' do
    let(:request_path) { "/users/#{username}/following" }
    subject { model.following }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end

  describe 'repos' do
    let(:request_path) { "/repositories/#{username}" }
    subject { model.repos }
    it { expect(subject).to be_an_instance_of(Tinybucket::Enumerator) }
  end
end
