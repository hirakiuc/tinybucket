require 'spec_helper'

RSpec.describe Tinybucket::Model::Project do
  include ApiResponseMacros

  let(:model_json) { load_json_fixture('teams/test_team/projects/myprj/get') }
  let(:owner) { model_json["owner"]["username"] }
  let(:project_key) { model_json["name"] }
  let(:instance) { Tinybucket::Model::Project.new(model_json) }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Project,
                  load_json_fixture('teams/test_team/projects/myprj/get')

  describe '#update' do
    let(:request_path) { "/teams/#{owner}/projects/#{project_key}" }
    before { stub_apiresponse(:put, request_path) }
    subject { instance.update(name: 'New project name') }
    it do 
      expect(subject).to be_an_instance_of(Tinybucket::Model::Project) 
    end
  end

  describe '#destroy' do
    let(:request_path) { "/teams/#{owner}/projects/#{project_key}" }
    before { stub_apiresponse(:delete, request_path) }
    subject { instance.destroy }
    it { expect(subject).to be_nil }
  end

  describe '#repos' do
    subject { instance.repos }

    context 'with loaded instance' do
      let(:owner) { 'test_team' }
      let(:request_path) { "/repositories/#{owner}?q='project.key=myprj'" }
      before { stub_apiresponse(:get, request_path) }
      it { expect(subject).to be_an_instance_of(Tinybucket::Resource::Repos) }
    end

    context 'with the instance which does not have owner property' do
      let(:instance) { Tinybucket::Model::Project.new({}) }

      it { expect { subject }.to raise_error('This project is not loaded yet.') }
    end
  end
end
