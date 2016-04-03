require 'spec_helper'

RSpec.describe Tinybucket::Resource::BranchRestrictions do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::BranchRestrictions.new(repo, options) }

  describe 'constructor' do
    subject { resource }
    it 'create new instance' do
      expect(subject).to be_an_instance_of(
        Tinybucket::Resource::BranchRestrictions)
    end
  end

  describe '#create' do
    subject { resource.create({}) }
    it { expect { subject.create }.to raise_error(NotImplementedError) }
  end

  describe '#find' do
    let(:restriction_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/branch-restrictions/#{restriction_id}"
    end
    subject { resource.find(restriction_id, {}) }
    before { stub_apiresponse(:get, request_path, {}) }
    it 'return model' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::BranchRestriction)
    end
  end

  describe 'Enumerable Methods' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/branch-restrictions" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::BranchRestriction)
        end
      end
    end
  end
end
