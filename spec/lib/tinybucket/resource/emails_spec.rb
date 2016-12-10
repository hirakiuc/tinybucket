require 'spec_helper'

RSpec.describe Tinybucket::Resource::Emails do
  include ApiResponseMacros

  let(:resource) { Tinybucket::Resource::Emails.new }

  describe 'Enumerable Methods' do
    let(:request_path) { "/user/emails" }
    before { stub_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::Email)
        end
      end
    end
  end
end
