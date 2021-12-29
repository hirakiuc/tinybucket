require 'feature_helper'
require 'pry'

RSpec.describe 'Branches or Branch Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }

  describe 'GET branches of the repository' do
    subject { repo.branches }
    it 'is enumerable' do
      subject.take(2).each do |branch|
        puts "branch: #{branch}"
        expect(branch).to be_an_instance_of(Tinybucket::Model::Branch)
      end
    end
  end

  describe 'GET a branch of the repository' do
    subject { repo.branch('add_second_section') }
    it 'should return a Branch' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::Branch)
    end
  end

  describe 'GET commits of the branch' do
    subject { repo.branch('add_second_section').commits }
    it 'should return the commits in the branch' do
      subject.take(2).each do |commit|
        puts "commit: #{commit}"
        expect(commit).to be_an_instance_of(Tinybucket::Model::Commit)
      end
    end
  end
end
