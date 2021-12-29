require 'feature_helper'

RSpec.describe 'diff Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }
  let(:commit_id) { 'f0222b6' }

  context 'GET a diff' do
    subject { repo.diff(commit_id) }
    it { expect(subject).to be_an_instance_of(String) }
  end

  context 'GET a patch' do
    subject { repo.patch(commit_id) }
    it { expect(subject).to be_an_instance_of(String) }
  end
end
