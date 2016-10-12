require 'spec_helper'

RSpec.describe Tinybucket::Api::EmailsApi do
  include ApiResponseMacros

  let(:request_path) { nil }
  let(:options) { {} }

  let(:api) do
    Tinybucket::Api::EmailsApi.new
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  describe 'list' do
    subject { api.list(options) }
    let(:request_path) { "/user/emails" }

    it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
  end

  describe 'find' do
    let(:email) { 'email@somedomain.com' }
    subject { api.find(email, options) }

    context 'without email' do
      let(:email) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with email' do
      let(:request_path) do
        "/user/emails/#{email}"
      end
      it { expect(subject).to be_instance_of(Tinybucket::Model::Email) }
    end
  end
end
