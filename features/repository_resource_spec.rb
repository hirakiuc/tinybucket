require 'feature_helper'

RSpec.describe 'Repository Resource' do
  let(:bucket) { Tinybucket.new }
  let(:owner_name) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:repo) { bucket.repo(owner_name, repo_name) }

  context 'GET a repository' do
    subject { repo }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Repository) }
    it { expect(subject.loaded?).to be_falsey }
  end

  describe 'Repos Resource' do
    let(:repos) { bucket.repos(owner_name) }

    describe 'POST a new repository' do
      it { expect { repos.create({}) }.to raise_error(NotImplementedError) }
    end
  end

  context 'Load a repository' do
    it 'can load repository' do
      attrs = repo.attributes
      expect { repo.load }.to change { repo.loaded? }.to(true)

      expect(repo.attributes).not_to eq(attrs)
    end
  end

  context 'DELETE a repository' do
    let(:repo_name) { 'not_exist_repo' }
    it { expect { repo.destroy }.to raise_error(NotImplementedError) }
  end

  context 'GET a list of watchers' do
    subject { repo.watchers }
    it { expect(subject.size).to eq(2) }
    it 'is enumerable' do
      subject.each do |watcher|
        expect(watcher).to be_an_instance_of(Tinybucket::Model::Profile)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username).sort).to eq(%w(altabjpworks hirakiuc))
    end
  end

  context 'GET a list of forks' do
    subject { repo.forks }
    it { expect(subject.size).to eq(1) }
    it 'is enumerable' do
      subject.each do |repo|
        expect(repo).to be_an_instance_of(Tinybucket::Model::Repository)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:full_name)).to eq(['hirakiuc/sandbox'])
    end
  end
end
