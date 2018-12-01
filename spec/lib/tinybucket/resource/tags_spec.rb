
require 'spec_helper'

RSpec.describe Tinybucket::Resource::Tags do
  include ApiResponseMacros

  let(:tag) { "3.8" }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Tags.new(repo, options) }

  describe '#find' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/tags/#{tag}" }
    before { stub_apiresponse(:get, request_path) }
    subject { resource.find(tag) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Tag) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/refs/tags" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Tag)
        end
      end
    end
  end
end
