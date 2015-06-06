require 'spec_helper'

RSpec.describe Tinybucket::Model::BranchRestriction do
  include ApiResponseMacros

  let(:model_json) { load_json_fixture('branch_restriction') }

  let(:request_method) { :get }
  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:model) do
    m = Tinybucket::Model::BranchRestriction.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug

    m
  end

  before { stub_apiresponse(:get, request_path, stub_options) if request_path }

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::BranchRestriction,
                  load_json_fixture('branch_restriction')

  describe '#update' do
    pending 'TODO implement method'
  end

  describe '#destroy' do
    pending 'TODO implement method'
  end
end
