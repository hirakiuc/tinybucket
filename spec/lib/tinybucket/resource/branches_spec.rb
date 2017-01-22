require 'spec_helper'

RSpec.describe Tinybucket::Resource::Branches do
  include ApiResponseMacros

  let(:branch) { "master" }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Branches.new(repo, options) }

  describe '#find' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/branches/#{branch}" }
    before { stub_apiresponse(:get, request_path) }
    subject { resource.find(branch) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Branch) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/branches" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Branch)
        end
      end
    end
  end
end
