require 'spec_helper'

RSpec.describe Tinybucket::Api::TeamApi do
  include ApiResponseMacros

  let(:api_config) { {} }
  let(:api) do
    api = Tinybucket::Api::TeamApi.new(api_config)
    api.teamname = teamname
    api
  end

  let(:teamname) { 'test_team' }
  let(:request_path) { nil }
  before { stub_apiresponse(:get, request_path) if request_path }

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'profile' do
    subject { api.profile }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Team) }
    end
  end

  describe 'members' do
    subject { api.members }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/members" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

  describe 'followers' do
    subject { api.followers }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/followers" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

  describe 'following' do
    subject { api.following }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/following" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

  describe 'repos' do
    subject { api.repos }

    context 'when without teamname' do
      let(:teamname) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with teamname' do
      let(:request_path) { "/teams/#{teamname}/repositories" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Models::Page) }
    end
  end

end
