require 'spec_helper.rb'

RSpec.describe Bitbucket::Client do
  include ApiResponseMacros

  let(:client) { Bitbucket::Client.new({}) }

  describe 'new' do
    let(:options) { {} }

    context 'without block' do
      subject { Bitbucket::Client.new(options) }
      it { expect(subject.config).to eq(options) }
    end

    context 'with block' do
      subject do
        Bitbucket::Client.new do |config|
          options.each_pair do |key, value|
            config.send("#{key}=", value)
          end
        end
      end
      it { expect(subject.config).to eq(options) }
    end
  end

  describe 'repos' do
    subject { client.repos }
    before { stub_apiresponse(:get, '/repositories') }
    it { expect(subject).to be_instance_of(Bitbucket::Models::Page) }
  end

  describe 'repo' do
    let(:owner) { 'test_owner' }
    let(:repo_slug) { 'test_repo' }
    let(:request_path) { "/repositories/#{owner}/#{repo_slug}" }

    before { stub_apiresponse(:get, request_path) }
    subject { client.repo(owner, repo_slug) }

    it { expect(subject).to be_instance_of(Bitbucket::Models::Repository) }
  end

  describe 'teams' do
    subject { client.teams }
    it { expect(subject).to be_instance_of(Bitbucket::Api::TeamsApi) }
  end

  describe 'users' do
    subject { client.users }
    it { expect(subject).to be_instance_of(Bitbucket::Api::UsersApi) }
  end
end
