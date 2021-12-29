require 'feature_helper'
require 'pry'

RSpec.describe 'Hooks or hook Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }

  describe 'GET hooks for the repository' do
    subject { repo.hooks }
    it { expect(subject.size).to eq(1) }
    it 'is enumerable' do
      subject.take(1).each do |hook|
        p hook
        expect(hook).to be_an_instance_of(Tinybucket::Model::Hook)
      end
    end
  end

  describe 'GET the hook of the repository' do
    let(:uuid) { '{1c100124-2bf2-4504-aff3-fb0f4e744ce1}' }
    subject { repo.hook(uuid) }
    it 'should be a Hook model instance' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::Hook)
      expect(subject.uuid).to eq(uuid)
    end
  end
end
