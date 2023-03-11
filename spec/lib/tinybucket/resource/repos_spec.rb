require 'spec_helper'

RSpec.describe Tinybucket::Resource::Repos do
  include ApiResponseMacros

  let(:options) { {} }

  describe 'Public Repos Resource' do
    let(:owner) { nil }
    let(:resource) { Tinybucket::Resource::Repos.new(owner, options) }
    
    describe '#list' do
      let(:params) { {} }
      let(:request_path) { '/repositories' }
      before { stub_enum_response(:get, request_path) }
      subject { resource.list(params) }
      it { expect(subject).to be_a(Tinybucket::Model::Page) }
      let(:repositories){ subject.items }
      it { expect(repositories).not_to be_empty }
      it { expect(repositories).to all(be_a(Tinybucket::Model::Repository)) }
    end

    describe '#find' do
      let(:slug) { 'test_repo' }
      subject { resource.find(slug) }

      it { expect(subject).to be_nil }
    end

    describe '#create' do
      context 'with repo slug' do 
        let(:params) { {} }
        let(:slug) { 'test_repo' }
        subject{ resource.create(slug, params) }
        it { expect{ subject }.to raise_error(ArgumentError, 'must provide an owner in order to create a repository') }
      end

      context 'without repo slug' do 
        let(:params) { {} }
        let(:slug) { nil }
        subject{ resource.create(slug, params) }
        it { expect{ subject }.to raise_error(ArgumentError, 'must provide an owner in order to create a repository') }
      end
    end

    describe 'Enumerable Methods' do
      let(:request_path) { '/repositories' }
      before { stub_enum_response(:get, request_path) }
      
      describe '#take(1)' do
        subject { resource.take(1) }
        it { expect(subject).to be_an(Array) }
      end

      describe '#each' do
        it 'iterate models' do
          resource.each do |m|
            expect(m).to be_a(Tinybucket::Model::Repository)
          end
        end
      end
    end
  end

  describe 'Owner\'s Repos Resource' do
    let(:owner) { 'test_owner' }
    let(:resource) { Tinybucket::Resource::Repos.new(owner, options) }

    describe '#list' do
      let(:params) { {} }
      let(:request_path) { "/repositories/#{owner}" }
      before { stub_enum_response(:get, request_path) }
      subject { resource.list(params) }
      it { expect(subject).to be_a(Tinybucket::Model::Page) }
      let(:repositories){ subject.items }
      it { expect(repositories).not_to be_empty }
      it { expect(repositories).to all(be_a(Tinybucket::Model::Repository)) }
      let(:usernames){ repositories.map{|item| item.owner["username"]} }
      it { expect(usernames.uniq.count).to eq(1) }
      it { expect(usernames).to eq(['test_owner']) }
    end

    describe '#find' do
      context 'with repo slug' do 
        let(:slug) { 'test_repo' }
        let(:request_path) { "/repositories/#{owner}/#{slug}" }
        before { stub_enum_response(:get, request_path) }
        subject { resource.find(slug) }
        it { expect(subject).not_to be_nil }
        it { expect(subject).to be_a(Tinybucket::Model::Repository)}
      end

      context 'without repo slug' do 
        let(:slug) { nil } 
        subject { resource.find(slug) }
        it { expect(subject).to be_nil }
      end
    end

    describe '#create' do
      context 'with repo slug' do 
        let(:params) { {} }
        let(:slug) { 'test_repo' }
        let(:request_path) { "/repositories/#{owner}/#{slug}" }
        before { stub_enum_response(:post, request_path) }
        subject{ resource.create(slug, params) }
        it { expect(subject).not_to be_nil }
        it { expect(subject).to be_a(Tinybucket::Model::Repository) }        
      end

      context 'without repo slug' do 
        let(:params) { {} }
        let(:slug) { nil }
        subject{ resource.create(slug, params) }
        it { expect{ subject }.to raise_error(ArgumentError, 'must provide a repo slug in order to create a repository') }
      end
    end

    describe 'Enumerable Methods' do
      let(:request_path) { "/repositories/#{owner}" }
      before { stub_enum_response(:get, request_path) }

      describe '#take(1)' do
        subject { resource.take(1) }
        it { expect(subject).to be_an(Array) }
      end

      describe '#each' do
        it 'iterate models' do
          resource.each do |m|
            expect(m).to be_a(Tinybucket::Model::Repository)
          end
        end
      end
    end
  end
end
