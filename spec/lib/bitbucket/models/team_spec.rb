require 'spec_helper'

RSpec.describe Bitbucket::Models::Team do
  include ApiResponseMacros

  let(:teamname) { 'test_team' }

  let(:model_json) { JSON.load(File.read('spec/fixtures/profile.json')) }
  let(:model) do
    m = Bitbucket::Models::Team.new(model_json)
    m.username = teamname
    m
  end

  let(:request_path) { nil }

  before { stub_apiresponse(:get, request_path) if request_path }

  describe 'members' do
    let(:request_path) { "/teams/#{teamname}/members" }
    subject { model.members }
    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end

  describe 'followers' do
    let(:request_path) { "/teams/#{teamname}/followers" }
    subject { model.followers() }
    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end

  describe 'following' do
    let(:request_path) { "/teams/#{teamname}/following" }
    subject { model.following }
    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end

  describe 'repos' do
    let(:request_path) { "/teams/#{teamname}/repositories" }
    subject { model.repos }
    it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
  end
end
