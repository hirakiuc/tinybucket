require 'spec_helper'

RSpec.describe Tinybucket::Api::UserApi do
  include ApiResponseMacros

  let(:api) do
    api = Tinybucket::Api::UserApi.new
    api.username = user
    api
  end

  let(:email) { 'email@somedomain.com' }
  let(:user) { 'test_owner' }
  let(:request_path) { nil }
  before { stub_apiresponse(:get, request_path) if request_path }

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe 'profile' do
    subject { api.profile }

    context 'when without username' do
      let(:user) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with username' do
      let(:request_path) { "/users/#{user}" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Profile) }
    end
  end

  describe 'emails' do
    subject { api.emails }
    context "when requesting emails" do
      let(:request_path) { "/user/emails" }
      it { expect(subject).to be_instance_of(Tinybucket::Resource::Emails) }
    end
  end

  describe 'email' do
    context "when without email" do
      let(:request_path) { "/user/emails/#{email}" }
      it { expect { api.email(nil) }.to raise_error(ArgumentError) }
    end

    context "when with email" do
      let(:request_path) { "/user/emails/#{email}" }
      it { expect( api.email(email) ).to be_instance_of(Tinybucket::Model::Email) }
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
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
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
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'repos' do
    subject { api.repos }

    context 'when without username' do
      let(:user) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with username' do
      let(:request_path) { "/repositories/#{user}" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end
end
