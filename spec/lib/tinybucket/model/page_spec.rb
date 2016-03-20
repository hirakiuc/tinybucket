require 'spec_helper'

RSpec.describe Tinybucket::Model::Page do

  let(:json) do
    text = File.read('spec/fixtures/repositories/get.json')
    JSON.parse(text)
  end

  let(:klass) { Tinybucket::Model::Repository }
  let(:model) { Tinybucket::Model::Page.new(json, klass) }

  describe 'initialize' do
    subject { model }

    it 'create instance' do
      expect(subject).to be_an_instance_of(Tinybucket::Model::Page)

      expect(subject.attrs[:size]).to eq(json['size'])
      expect(subject.attrs[:page]).to eq(json['page'])
      expect(subject.attrs[:pagelen]).to eq(json['pagelen'])
      expect(subject.attrs[:next]).to eq(json['next'])
      expect(subject.attrs[:previous]).to eq(json['previous'])

      expect(subject.items.size).to eq(json['values'].size)
    end
  end
end
