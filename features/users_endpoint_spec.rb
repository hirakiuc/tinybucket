require 'feature_helper'

RSpec.describe 'Users Endpoint' do
  let(:user_name) { 'hirakiuc' }
  let(:bucket) { Tinybucket.new }

  let(:user) { bucket.user(user_name) }

  context 'GET the user profile' do
    subject { user }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Profile) }
    it { expect(subject.username).to eq(user_name) }
  end

  context 'GET the list of followers' do
    subject { user.followers }
    it { expect(subject.size).to eq(0) }
    skip 'is enumerable' do
      subject.each do |follower|
        expect(follower).to be_an_instance_of(Tinybucket::Model::Profile)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username)).to eq([])
    end
  end

  context 'GET a list of accounts the user is following' do
    subject { user.following }
    it { expect(subject.size).to eq(2) }
    it 'is enumerable' do
      subject.each do |following|
        expect(following).to be_an_instance_of(Tinybucket::Model::Profile)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username).sort).to eq(['altabjpworks', 'bitbucket'])
    end
  end

  context 'GET the user\'s repositories' do
    subject { user.repos }
    it { expect(subject.size).to be > 1 }
    it 'is enumerable' do
      subject.take(2).each do |repo|
        expect(repo).to be_an_instance_of(Tinybucket::Model::Repository)
      end
    end
  end
end
