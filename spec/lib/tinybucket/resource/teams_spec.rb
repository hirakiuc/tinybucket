require 'spec_helper'

RSpec.describe Tinybucket::Resource::Teams do
  include ApiResponseMacros

  let(:role_name) { "admin" }
  let(:resource) { Tinybucket::Resource::Teams.new(role_name) }

  describe "Enumerable Methods" do
    let(:request_path) { "/teams?role=#{role_name}" }
    before { stub_enum_response(:get, request_path) }

    describe "#take(1)" do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe "#each" do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Team)
        end
      end
    end
  end
end
