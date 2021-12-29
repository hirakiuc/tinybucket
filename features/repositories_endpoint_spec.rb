require 'feature_helper'

RSpec.describe 'Repositories Endpoint' do
  let(:bucket) { Tinybucket.new }
  let(:owner_name) { 'hirakiuc' }

  context 'GET a list of all public repositories' do
    subject { bucket.repos }
    it { expect(subject.size).to be_nil }
    it 'is enumerable' do
      subject.take(5).each do |repo|
        expect(repo).to be_an_instance_of(Tinybucket::Model::Repository)
      end
    end
  end

  context 'GET a list of repositories owned by the account' do
    subject { bucket.repos(owner_name) }
    it { expect(subject.size).to be > 1 }
    it 'is enumerable' do
      subject.take(3).each do |repo|
        expect(repo).to be_an_instance_of(Tinybucket::Model::Repository)
      end
    end
    it 'can use enumerable module method' do
      expect(subject.take(3).map(&:scm).uniq).to eq(['git'])
    end
  end
end
