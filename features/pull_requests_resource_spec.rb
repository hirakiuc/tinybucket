require 'feature_helper'

RSpec.describe 'PullRequests Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }
  let(:pull_request) { repo.pull_request(1) }

  context 'GET a list of open pull requests' do
    subject { repo.pull_requests(state: 'MERGED') }
    it { expect(subject.size).to be >= 1 }
    it 'is enumerable' do
      subject.take(3).each do |pr|
        expect(pr).to be_an_instance_of(Tinybucket::Model::PullRequest)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.take(3).map(&:title).uniq).not_to eq([''])
    end
  end

  context 'GET a specific pull request' do
    subject { pull_request }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::PullRequest) }
  end

  pending 'POST (create) a new pull request' do
    subject { repo.pull_request.create({}) }
    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  pending 'PUT a pull request update' do
    subject { pull_request.update({}) }
    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  context 'GET the commits for a pull request' do
    subject { pull_request.commits }
    it { expect(subject.size).to eq(1) }
    it 'is enumerable' do
      subject.take(2).each do |commit|
        expect(commit).to be_an_instance_of(Tinybucket::Model::Commit)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.take(2).map(&:hash)).not_to eq(['e2ab3a3'])
    end
  end

  context 'POST a pull request approval' do
    before  { pull_request.unapprove }
    subject { pull_request.approve }
    it { expect(subject).to be_truthy }
  end

  skip 'DELETE a pull request approval' do
    before  { pull_request.approve }
    subject { pull_request.unapprove }
    it { expect(subject).to be_truthy }
  end

  context 'GET the diff for a pull request' do
    subject { pull_request.diff }
    it { expect(subject).to be_an_instance_of(String) }
  end

  skip 'GET the log of all of a repository\'s pull request activity'
  skip 'GET the activity for a pull request'

  skip 'Accept and merge a pull request'
  skip 'Decline or reject a pull request'

  context 'GET a list of pull request comments' do
    subject { pull_request.comments }
    it { expect(subject.size).to eq(2) }
    it 'is enumerable' do
      subject.each do |comment|
        expect(comment).to be_an_instance_of(Tinybucket::Model::Comment)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:user).map {|v| v['username'] }.uniq).to eq(['hirakiuc'])
    end
  end

  context 'GET an individual pull request comment' do
    subject { pull_request.comment('15986003') }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Comment) }
    it { expect(subject).to be_loaded }
  end
end
