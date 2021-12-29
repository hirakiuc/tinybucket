require 'feature_helper'
require 'pry'

RSpec.describe 'Build Statuses Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }
  let(:commit_hash) { 'f0222b6' }

  let(:commit) { repo.commit(commit_hash) }

  describe 'GET build statuses' do
    subject { commit.build_statuses }

    context 'with a BuildStatus' do
      it 'is enumerable' do
        expect(subject.size).to eq(1)
        status = subject.take(1)[0]
        expect(status).to be_an_instance_of(Tinybucket::Model::BuildStatus)
      end
    end

    context 'with no BuildStatuses' do
      let(:commit_hash) { 'e2ab3a3' }
      it 'should return empty enumerable' do
        expect(subject.size).to eq(0)
      end
    end
  end
end
