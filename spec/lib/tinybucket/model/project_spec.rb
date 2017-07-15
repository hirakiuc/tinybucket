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
end
