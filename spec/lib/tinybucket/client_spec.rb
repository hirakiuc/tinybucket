require 'spec_helper.rb'

RSpec.describe Tinybucket::Client do
  include ApiResponseMacros

  let(:client) { Tinybucket::Client.new }

  describe 'new' do
    subject { Tinybucket::Client.new }
    it { expect(subject).to be_an_instance_of(Tinybucket::Client) }
  end

  describe 'repos' do
    context 'when get public repositories' do
      before { stub_apiresponse(:get, '/repositories') }

      context 'without options' do
        subject { client.repos }
        it { expect(subject).to be_instance_of(Tinybucket::Enumerator) }
      end
      context 'with options' do
        subject { client.repos(options) }
        let(:options) { {} }
        it { expect(subject).to be_instance_of(Tinybucket::Enumerator) }
      end
    end

    context 'when get repositories of the owner' do
      let(:owner) { 'test_owner' }
      before { stub_apiresponse(:get, request_path) }

      context 'without options' do
        let(:request_path) { "/repositories/#{owner}" }
        subject { client.repos(owner) }
        it { expect(subject).to be_instance_of(Tinybucket::Enumerator) }
      end
      context 'with options' do
        let(:request_path) { "/repositories/#{owner}" }
        subject { client.repos(owner, options) }
        let(:options) { {} }
        it { expect(subject).to be_instance_of(Tinybucket::Enumerator) }
      end
    end

    context 'when invalid argument passed' do
      context 'with a integer' do
        subject { client.repos(20) }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'with a string and string' do
        subject { client.repos('test_owner', 'test_repository') }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'with three arguments' do
        subject { client.repos('a', 'b', 'c') }
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

  describe 'repo' do
    let(:repo_owner) { 'test_owner' }
    let(:repo_slug) { 'test_repo' }

    subject { client.repo(repo_owner, repo_slug) }

    it 'return RepoApi instance' do
      expect(subject).to be_instance_of(Tinybucket::Model::Repository)
      expect(subject.repo_owner).to eq(repo_owner)
      expect(subject.repo_slug).to eq(repo_slug)
    end
  end

  describe 'team' do
    let(:team) { 'test_team' }
    subject { client.team(team) }
    it { expect(subject).to be_instance_of(Tinybucket::Model::Team) }
  end

  describe 'user' do
    let(:user) { 'test_owner' }
    subject { client.user(user) }
    it { expect(subject).to be_instance_of(Tinybucket::Model::Profile) }
  end
end
