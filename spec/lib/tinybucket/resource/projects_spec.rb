require 'spec_helper'

RSpec.describe Tinybucket::Resource::Projects do
  include ApiResponseMacros

  let(:owner) { 'test_team' }
  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Projects.new(owner, options) }

  describe '#find' do
    let(:project_key) { 'myprj' }
    let(:request_path) { "/teams/#{owner}/projects/#{project_key}" }
    before { stub_apiresponse(:get, request_path) }

    subject { resource.find(project_key) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end

  describe '#create' do
    let(:options) { { key: 'myprj', name: 'My project' } }
    let(:request_path) { "/teams/#{owner}/projects/" }
    before { stub_apiresponse(:post, request_path) }

    subject { resource.create(options) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Project) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) { "/teams/#{owner}/projects/" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Project)
        end
      end
    end
  end
end
