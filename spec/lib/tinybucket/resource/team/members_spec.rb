require 'spec_helper'

RSpec.describe Tinybucket::Resource::Team::Members do
  include ApiResponseMacros

  let(:team) { 'test_team' }
  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::Team::Members.new(team, options) }

  describe 'Enumerable Methods' do
    let(:request_path) { "/teams/#{team}/members" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Team)
        end
      end
    end
  end
end
