require 'spec_helper'

RSpec.describe Tinybucket::Api::CommitsApi do
  include ApiResponseMacros

  let(:request_path) { nil }
  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }
  let(:options) { {} }

  let(:api) do
    api = Tinybucket::Api::CommitsApi.new
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
      let(:request_path) { "/repositories/#{owner}/#{slug}/commits" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'find' do
    let(:revision) { '1' }
    subject { api.find(revision, options) }

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
        "/repositories/#{owner}/#{slug}/commit/#{revision}"
      end
      it { expect(subject).to be_instance_of(Tinybucket::Model::Commit) }
    end
  end

  describe 'approve' do
    let(:revision) { '1' }
    let(:request_method) { :post }

    subject { api.approve(revision, options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when pull request is not yet approved' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{revision}/approve"
      end

      it { expect(subject).to be_truthy }
    end

    context 'when pull request is already approved.' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{revision}/approve"
      end

      let(:stub_options) do
        {
          status_code: 409,
          message: JSON.generate(
            error: { message: 'You already approved this pull request.' }
          )
        }
      end
      it { expect(subject).to be_truthy }
    end
  end

  describe 'unapprove' do
    let(:revision) { '1' }
    let(:request_method) { :delete }
    subject { api.unapprove(revision) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when commit is not yet approved' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{revision}/approve"
      end

      let(:stub_options) do
        {
          status_code: 404,
          message: JSON.generate(
            error: { message: 'You haven\'t approve this pull request.' }
          )
        }
      end
      it { expect(subject).to be_truthy }
    end

    context 'when commit is already approved' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/commit/#{revision}/approve"
      end
      let(:stub_options) { { status_code: 204, message: '' } }

      it { expect(subject).to be_truthy }
    end
  end
end
