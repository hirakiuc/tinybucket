require 'spec_helper'

RSpec.describe Tinybucket::Model::Comment do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('comment') }

  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:commit) do
    m = Tinybucket::Model::Commit.new({})
    m.repo_owner = owner
    m.repo_slug  = slug
    m.hash = '1'
    m
  end

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::Comment,
                  load_json_fixture('comment')

  describe 'model can reloadable' do
    let(:comment) do
      m = Tinybucket::Model::Comment.new({})
      m.repo_owner = owner
      m.repo_slug  = slug
      m.commented_to = commit
      m.id = '1'
      m
    end

    before { @model = commit }
    it_behaves_like 'the model is reloadable'
  end
end
