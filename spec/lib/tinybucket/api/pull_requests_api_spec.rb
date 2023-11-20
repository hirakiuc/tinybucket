require 'spec_helper'

RSpec.describe Tinybucket::Api::PullRequestsApi do
  include ApiResponseMacros

  let(:api) do
    api = Tinybucket::Api::PullRequestsApi.new
    api.repo_owner = owner
    api.repo_slug = slug
    api
  end

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:request_path) { nil }
  let(:request_method) { :get }
  let(:stub_options) { nil }

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  describe 'list' do
    let(:options) { {} }

    subject { api.list(options) }

    context 'without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_owner' do
      let(:owner) { nil }
      let(:slug) { 'test_repo' }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without repo_slug' do
      let(:owner) { 'test_owner' }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with repo_owner and repo_slug' do
      let(:request_path) { "/repositories/#{owner}/#{slug}/pullrequests" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end

    context 'when request with state' do
      let(:options) { { state: state } }
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests?state=#{state}"
      end

      context 'when state is OPEN' do
        let(:state) { 'open' }
        it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
      end

      context 'when state is DECLINED' do
        let(:state) { 'declined' }
        it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
      end

      context 'when state is MERGED' do
        let(:state) { 'merged' }
        it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
      end
    end
  end

  describe 'find' do
    let(:pr_id) { 1 }
    subject { api.find(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/#{pr_id}"
      end

      it 'return pull request model' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::PullRequest)
      end
    end
  end

  describe 'commits' do
    let(:pr_id) { 1 }
    subject { api.commits(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/commits"
      end
      it 'return page model which contains commit models' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::Page)
      end
    end
  end

  describe 'activities' do
    let(:pr_id) { 1 }
    subject { api.activities(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/activity"
      end
      it 'return page model which contains activity models' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::Page)
      end
    end
  end

  describe 'diffstat' do
    let(:pr_id) { 1 }
    subject { api.diffstats(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/diffstat"
      end
      it 'return page model which contains diffstat models' do
        expect(subject).to be_an_instance_of(Tinybucket::Model::Page)
      end
    end
  end

  describe 'approve' do
    let(:pr_id) { 1 }
    let(:request_method) { :post }
    subject { api.approve(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/approve"
      end
      context 'when pull request is not yet approved.' do
        it { expect(subject).to be_truthy }
      end
      context 'when pull request is already approved.' do
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
  end

  describe 'unapprove' do
    let(:pr_id) { 1 }
    let(:request_method) { :delete }
    subject { api.unapprove(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/approve"
      end

      context 'when pull request is approved' do
        # In this case, bitbucket api respond '204 No content'.
        let(:stub_options) { { status_code: 204, message: '' } }
        it { expect(subject).to be_truthy }
      end

      context 'when pull request is not approved yet.' do
        # In this case, bitbucket api respond '404 NotFound'.
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
    end
  end

  describe 'diff' do
    let(:pr_id) { 1 }
    subject { api.diff(pr_id) }

    context 'when without repo_owner and repo_slug' do
      let(:owner) { nil }
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when without repo_slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when with repo_owner and repo_slug' do
      let(:stub_options) do
        { content_type: 'plain/text' }
      end
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/pullrequests/1/diff"
      end
      it { expect(subject).to be_instance_of(String) }
    end
  end
end
