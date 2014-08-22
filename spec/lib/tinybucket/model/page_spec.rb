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

  describe 'size' do
    subject { model.size }

    let(:base_json) do
      text = File.read('spec/fixtures/repositories/get.json')
      JSON.parse(text)
    end

    context 'when json contains size = nil' do
      let(:json) do
        base_json['size'] = nil
        base_json
      end
      it { expect(subject).to be_nil }
    end

    context 'when json contains size' do
      let(:size) { 1000 }
      let(:json) do
        base_json['size'] = size
        base_json
      end
      it { expect(subject).to eq(size) }
    end
  end

  describe 'each' do
    pending 'TODO add specs'
  end
end
