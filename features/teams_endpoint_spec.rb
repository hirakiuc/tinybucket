require 'feature_helper'

RSpec.describe 'Teams Endpoint' do
  let(:team_name) { 'altabjpworks' }
  let(:bucket) { Tinybucket.new }

  let(:team) { bucket.team(team_name) }

  context 'GET the team profile' do
    subject { team }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Team) }
  end

  context 'GET the team members' do
    subject { team.members }
    it { expect(subject.size).to eq(1) }
    it 'is enumerable' do
      subject.each do |member|
        expect(member).to be_an_instance_of(Tinybucket::Model::Team)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username)).to eq(['hirakiuc'])
    end
  end

  context 'GET the team followers' do
    subject { team.followers }
    it { expect(subject.size).to eq(1) }
    it 'is enumerable' do
      subject.each do |follower|
        expect(follower).to be_an_instance_of(Tinybucket::Model::Team)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username)).to eq(['hirakiuc'])
    end
  end
  context 'GET the team following' do
    subject { team.following }
    it { expect(subject.size).to eq(0) }
    it 'is enumerable' do
      subject.each do |following|
        expect(following).to be_an_instance_of(Tinybucket::Model::Team)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.map(&:username)).to eq([])
    end
  end

  context 'GET the team\'s repositories' do
    subject { team.repos }
    it { expect(team.repos.size).to eq(1) }
    it 'is enumerable' do
      subject.take(2).each do |repo|
        expect(repo).to be_an_instance_of(Tinybucket::Model::Repository)
      end
    end
    it 'can use enumerable module method' do
      expect(
        subject.take(2).map(&:scm).uniq
      ).to eq(['git'])
    end
  end
end
