require 'spec_helper'

RSpec.describe Tinybucket::Resource::Hooks do
  include ApiResponseMacros

  let(:hook) { "{ABC-321-ABC-456}" }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:hook_payload)  do
    {
      :url => "https://mywebapp.com/bitbucket/hook",
      :description => "Here's my description",
      :events => ['issue:created', 'issue:updated', 'issue:comment_created'],
      :active => true,
    }
  end

  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Hooks.new(repo, options) }

  describe '#find' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/hooks/#{hook}" }
    before { stub_apiresponse(:get, request_path) }
    subject { resource.find(hook) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Hook) }
  end

  describe '#create' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/hooks" }
    before { stub_apiresponse(:post, request_path) }
    subject { resource.create(hook_payload[:url], hook_payload[:events], hook_payload[:description], hook_payload[:active]) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Hook) }
  end


  describe 'Enumerable Methods' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/hooks" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Hook)
        end
      end
    end
  end
end
