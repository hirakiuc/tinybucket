require 'spec_helper'

RSpec.describe Tinybucket::Resource::Watchers do
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
  let(:resource) { Tinybucket::Resource::Watchers.new(repo, options) }

  describe 'Enumerable Methods' do
    let(:params) { {} }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/watchers"
    end
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Profile)
        end
      end
    end
  end
end
