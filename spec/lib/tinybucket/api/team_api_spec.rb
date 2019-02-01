require 'spec_helper'

RSpec.describe Tinybucket::Api::TeamApi do
  include ApiResponseMacros

  let(:api) { Tinybucket::Api::TeamApi.new }
  let(:teamname) { 'test_team' }
  let(:request_path) { nil }
  before { stub_apiresponse(:get, request_path) if request_path }

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'list' do
    subject { api.list(role_name) }

    let(:role_name) { "admin" }
    let(:request_path) { "/teams?q=role=\"admin\"" }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'profile' do
    subject { api.find(teamname) }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Team) }
    end
  end

  describe 'members' do
    subject { api.members(teamname) }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/members" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'followers' do
    subject { api.followers(teamname) }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/followers" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'following' do
    subject { api.following(teamname) }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/following" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'repos' do
    subject { api.repos(teamname) }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/repositories" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end
end
