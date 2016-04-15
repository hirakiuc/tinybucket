require 'spec_helper'

RSpec.describe Tinybucket::Resource::Commit::Comments do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }
  let(:revision) { '1' }
  let(:commit) do
    Tinybucket::Model::Commit.new({}).tap do |m|
      m.hash = revision
      m.repo_owner = owner
      m.repo_slug = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Commit::Comments.new(commit, options) }

  describe '#find' do
    let(:comment_id) { '1' }
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/comments/#{comment_id}"
    end
    subject { resource.find(comment_id) }
    before { stub_apiresponse(:get, request_path) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Comment) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) do
      "/repositories/#{owner}/#{slug}/commit/#{revision}/comments"
    end
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Comment)
        end
      end
    end
  end
end
