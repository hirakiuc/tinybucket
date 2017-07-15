require 'spec_helper'

RSpec.describe Tinybucket::Model::Project do
  include ApiResponseMacros

  let(:model_json) { load_json_fixture('teams/test_team/projects/myprj/get') }
  let(:instance) { Tinybucket::Model::Project.new(model_json) }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Project,
                  load_json_fixture('teams/test_team/projects/myprj/get')

  describe '#update' do
    subject { instance.update({}) }
    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  describe '#destroy' do
    subject { instance.destroy() }
    it { expect { subject }.to raise_error(NotImplementedError) }
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
