require 'spec_helper'

RSpec.describe Bitbucket::Api::UserApi do
  include ApiResponseMacros

  let(:api_config) { {} }
  let(:api) do
    api = Bitbucket::Api::UserApi.new(api_config)
    api.username = user
    api
  end

  let(:user) { 'test_owner' }
  let(:request_path) { nil }
  before { stub_apiresponse(:get, request_path) if request_path }

  it { expect(api).to be_a_kind_of(Bitbucket::Api::BaseApi) }

  describe 'profile' do
    subject { api.profile }

    context 'when without username' do
      let(:user) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with username' do
      let(:request_path) { "/users/#{user}" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Profile) }
    end
  end

  describe 'followers' do
    subject { api.followers }

    context 'when without username' do
      let(:user) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with username' do
      let(:request_path) { "/users/#{user}/followers" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end

  describe 'following' do
    subject { api.following }

    context 'when without username' do
      let(:user) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with username' do
      let(:request_path) { "/users/#{user}/following" }
      it { expect(subject).to be_an_instance_of(Bitbucket::Models::Page) }
    end
  end
end
