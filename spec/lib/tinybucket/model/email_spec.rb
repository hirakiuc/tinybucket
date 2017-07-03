require 'spec_helper'

RSpec.describe Tinybucket::Model::Email do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('email') }

  let(:request_path) { nil }


  let(:model) do
    m = Tinybucket::Model::Email.new(model_json)
    m
  end

  before { stub_apiresponse(:get, request_path) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Email,
                  load_json_fixture('email')

  describe 'model can reloadable' do
    let(:email) do
      m = Tinybucket::Model::Email.new({})
      m
    end
    before { @model = email }
    it_behaves_like 'the model is reloadable'
  end
end
