require 'spec_helper'

RSpec.describe Tinybucket::Resource::Repos do
  include ApiResponseMacros

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Repos.new(owner, options) }

  describe 'Public Repos Resource' do
    let(:owner) { nil }

    describe '#create' do
      let(:params) { {} }
      subject { resource.create(params) }
      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    describe '#find' do
      let(:params) { {} }
      subject { resource.find(params) }
      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    describe 'Enumerable Methods' do
      let(:request_path) { '/repositories' }
      before { stub_enum_response(:get, request_path) }

      describe '#take(1)' do
        subject { resource.take(1) }
        it { expect(subject).to be_an_instance_of(Array) }
      end

      describe '#each' do
        it 'iterate models' do
          resource.each do |m|
            expect(m).to be_an_instance_of(Tinybucket::Model::Repository)
          end
        end
      end
    end
  end

  describe 'Owner\'s Repos Resource' do
    let(:owner) { 'test_owner' }

    describe '#create' do
      let(:params) { {} }
      subject { resource.create(params) }
      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    describe '#find' do
      let(:params) { {} }
      subject { resource.find(params) }
      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    describe 'Enumerable Methods' do
      let(:request_path) { "/repositories/#{owner}" }
      before { stub_enum_response(:get, request_path) }

      describe '#take(1)' do
        subject { resource.take(1) }
        it { expect(subject).to be_an_instance_of(Array) }
      end

      describe '#each' do
        it 'iterate models' do
          resource.each do |m|
            expect(m).to be_an_instance_of(Tinybucket::Model::Repository)
          end
        end
      end
    end
  end
end
