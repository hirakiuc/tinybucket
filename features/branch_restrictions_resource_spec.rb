require 'feature_helper'

RSpec.describe 'Branch Restriction Resource' do
  let(:repo_owner) { 'altabjpworks' }
  let(:repo_name) { 'sandbox' }

  let(:bucket) { Tinybucket.new }
  let(:repo) { bucket.repo(repo_owner, repo_name) }

  context 'GET the branch-restrictions' do
    subject { repo.branch_restrictions }
    it { expect(subject.size).to eq(3) }
    it 'is enumerable' do
      subject.each do |restriction|
        expect(restriction).to be_an_instance_of(Tinybucket::Model::BranchRestriction)
      end
    end
    it 'can use enumerable module method' do
      expect(
        subject.map(&:id).sort
      ).to eq([1069546, 1069547, 1357838])
    end
  end

  skip 'POST the branch-restrictions'

  context 'GET a specific restriction' do
    let(:restriction_id) { '1069546' }
    subject { repo.branch_restriction(restriction_id) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::BranchRestriction) }
    xit { expect(subject).to be_loaded }
  end

  skip 'PUT a branch restriction update'
  skip 'DELETE the branch restriction'
end
