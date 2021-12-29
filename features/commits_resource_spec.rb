require 'feature_helper'
require 'pry'

RSpec.describe 'Commits or commit Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }

  context 'GET a commits list for a repository' do
    subject { repo.commits }
    it { expect(subject.size).to be_nil }
    it 'is enumerable' do
      subject.take(2).each do |commit|
        expect(commit).to be_an_instance_of(Tinybucket::Model::Commit)
      end
    end
    it 'can use enumerable module method' do
      expect(
        subject.take(2).map(&:hash).sort
      ).to eq(
        %w(2133dc9b0838d926e6682d9b19e512beabe42424 533c11ea4161f4cb26e266c3b9fc69ad79b90d2d)
      )
    end
  end

  context 'GET an individual commit' do
    let(:hash) { '2133dc9b0838d926e6682d9b19e512beabe42424' }
    subject { repo.commit(hash) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Commit) }
    it { expect(subject).to be_loaded }
    it { expect(subject).not_to be_nil }
  end

  context 'GET a list of commit comments' do
    let(:hash) { '2133dc9b0838d926e6682d9b19e512beabe42424' }
    let(:commit) { repo.commit(hash) }
    subject { commit.comments }
    it { expect(subject.size).to eq(2) }
    it 'is enumerable' do
      subject.take(2).each do |comment|
        expect(comment).to be_an_instance_of(Tinybucket::Model::Comment)
      end
    end
    it 'can use enumerable module method' do
      expect(
        subject.take(2).map(&:id).sort
      ).to eq([2937818, 2937820])
    end
  end

  context 'GET an individual commit comment' do
    let(:hash) { '2133dc9b0838d926e6682d9b19e512beabe42424' }
    let(:commit) { repo.commit(hash) }
    let(:comment_id) { '2937818' }
    subject { commit.comment(comment_id) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Comment) }
    it { expect(subject).to be_loaded }
  end

  context 'POST a commit approval' do
    let(:hash) { 'e2ab3a3' }
    let(:commit) { repo.commit(hash) }

    before { commit.unapprove }
    subject { commit.approve }

    it { expect(subject).to be_truthy }
  end

  context 'DELETE a commit approval' do
    let(:hash) { 'e2ab3a3' }
    let(:commit) { repo.commit(hash) }

    before { commit.approve }
    subject { commit.unapprove }

    it { expect(subject).to be_truthy }
  end
end
