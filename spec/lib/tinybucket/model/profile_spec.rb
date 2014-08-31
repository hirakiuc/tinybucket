require 'spec_helper'

RSpec.describe Tinybucket::Model::Profile do
  include ApiResponseMacros
  include ModelMacros

  let(:username) { 'test_owner' }

  let(:model_json) { JSON.load(File.read('spec/fixtures/profile.json')) }
  let(:model) do
    m = Tinybucket::Model::Profile.new(model_json)
    m.username = username
    m
  end

  let(:request_path) { nil }

  before { stub_apiresponse(:get, request_path) if request_path }

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
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'following' do
    let(:request_path) { "/users/#{username}/following" }
    subject { model.following }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'repos' do
    let(:request_path) { "/repositories/#{username}" }
    subject { model.repos }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end
end
