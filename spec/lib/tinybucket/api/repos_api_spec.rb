require 'spec_helper.rb'

RSpec.describe Tinybucket::Api::ReposApi do
  include ApiResponseMacros

  let(:api) { Tinybucket::Api::ReposApi.new }

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  describe '#list' do
    subject { api.list(options) }

    before { stub_apiresponse(:get, request_path) }

    context 'without owner' do
      let(:options) { {} }
      let(:request_path) { '/repositories' }
      it { expect(subject).to be_a(Tinybucket::Model::Page) }
      let(:repositories){ subject.items }
      it { expect(repositories).not_to be_empty }
      it { expect(repositories).to all(be_a(Tinybucket::Model::Repository)) }
    end

    context 'with owner' do
      let(:owner) { 'test_owner' }
      let(:options) { { owner: owner } }
      let(:request_path) { "/repositories/#{owner}" }
      it { expect(subject).to be_a(Tinybucket::Model::Page) }
      let(:repositories){ subject.items }
      it { expect(repositories).not_to be_empty }
      it { expect(repositories).to all(be_a(Tinybucket::Model::Repository)) }
      let(:usernames){ repositories.map{|item| item.owner["username"]} }
      it { expect(usernames.uniq.count).to eq(1) }
      it { expect(usernames).to eq(['test_owner']) }
    end
  end

  describe '#find' do
    let(:owner) { 'test_owner' }
    let(:slug) { 'test_repo' }
    let(:request_path) { "/repositories/#{owner}/#{slug}" }

    before { stub_apiresponse(:get, request_path) }
    subject{ api.find(owner, slug) }
    it { expect(subject).to be_a(Tinybucket::Model::Repository) }
  end

  describe '#create' do
    let(:params) { {} }
    let(:owner) { 'test_owner' }
    let(:slug) { 'test_repo' }
    let(:request_path) { "/repositories/#{owner}/#{slug}" }
    before { stub_apiresponse(:post, request_path) }

    subject { api.create(owner, slug, params) }
    it { expect(subject).to be_a(Tinybucket::Model::Repository) }
  end
end
