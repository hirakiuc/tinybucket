require 'spec_helper'

RSpec.describe Tinybucket::Model::BranchRestriction do
  include ApiResponseMacros

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  # TODO: fix model_json
  let(:model_json) { nil }

  let(:model) do
    m = Tinybucket::Model::BranchRestriction.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug

    m
  end

  before { stub_apiresponse(:get, request_path, stub_options) if request_path }

  describe '#update' do
    pending 'TODO implement method'
  end

  describe '#destroy' do
    pending 'TODO implement method'
  end
end
