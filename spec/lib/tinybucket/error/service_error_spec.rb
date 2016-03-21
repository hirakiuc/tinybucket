require 'spec_helper'

RSpec.describe Tinybucket::Error::ServiceError do
  context 'initialize' do
    let(:env) do
      {
        response_headers: [],
        method: 'POST',
        url: 'https://api.example.org/path/to',
        status: 500,
        body: 'Internal Server Error'
      }
    end

    subject { Tinybucket::Error::ServiceError.new(env) }

    it { expect(subject).to be_an_instance_of(Tinybucket::Error::ServiceError) }
    it { expect(subject.http_method).to eq(env[:method]) }
    it { expect(subject.request_url).to eq(env[:url]) }
    it { expect(subject.status_code).to eq(env[:status]) }
    it { expect(subject.response_body).to eq(env[:body]) }
  end
end
