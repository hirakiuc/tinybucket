require 'spec_helper'

RSpec.describe Tinybucket::Api::HooksApi do
  include ApiResponseMacros

  let(:hook) { "{ABC-321-ABC-456}" }
  let(:hook_payload)  do
    {
      :url => "https://mywebapp.com/bitbucket/hook",
      :description => "Here's my description",
      :events => ['issue:created', 'issue:updated', 'issue:comment_created'],
      :active => true,
    }
  end

  let(:request_path) { nil }
  let(:options) { {} }
  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:api) do
    api = Tinybucket::Api::HooksApi.new
    api.repo_owner = owner
    api.repo_slug  = slug
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  describe 'list' do
    subject { api.list(options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) { "/repositories/#{owner}/#{slug}/hooks" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'find' do
    subject { api.find(hook, options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/hooks/#{hook}"
      end
      it { expect(subject).to be_instance_of(Tinybucket::Model::Hook) }
    end
  end

  describe 'post' do
    subject { api.post(hook_payload[:url], hook_payload[:events], hook_payload[:description], hook_payload[:active], options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_method) { :post }
      let(:request_path) { "/repositories/#{owner}/#{slug}/hooks" }
      it { expect(subject).to be_instance_of(Tinybucket::Model::Hook) }
    end
  end

  describe 'update' do
    subject { api.update(hook, hook_payload) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without hook' do
      let(:hook) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_method) { :put }
      let(:request_path) { "/repositories/#{owner}/#{slug}/hooks/#{hook}" }
      it { expect(subject).to be_truthy }
    end
  end

  describe 'delete' do
    subject { api.delete(hook) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without hook' do
      let(:hook) { nil }
      it { expect { api.delete(hook) }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_method) { :delete }
      let(:request_path) { "/repositories/#{owner}/#{slug}/hooks/#{hook}" }
      it { expect(subject).to be_truthy }
    end
  end

end
