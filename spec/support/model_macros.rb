module ModelMacros
  RSpec.shared_examples 'model has acceptable_attributes' do |cls, model_json|
    describe '#attribute=' do
      subject { cls.new(json) }

      context 'json contains only expected attrs' do
        let(:json) { model_json }
        it { expect { subject }.not_to raise_error }
        it 'receive each attributes' do
          json.each_pair do |key, value|
            expect(subject.send(key.intern)).to eq(value)
          end
        end
      end

      context 'json contains un-acceptable attrs' do
        let(:json) { model_json.merge('_un_acceptable_key' => 'some_value') }
        it { expect { subject }.not_to raise_error }
        it 'receive each acceptable attributes' do
          model_json.each_pair do |key, value|
            expect(subject.send(key.intern)).to eq(value)
          end
        end
      end
    end
  end

  RSpec.shared_examples 'the model is reloadable' do
    describe '#load' do
      before do
        allow(@model).to \
          receive_message_chain(:load_model, :attributes).and_return({})
      end
      subject { @model.load }

      context 'when not loaded' do
        it { expect(subject).to be_truthy }
      end

      context 'when load failed' do
        before do
          allow(@model).to receive(:load_model).and_raise(ArgumentError)
        end

        it { expect(subject).to be_falsey }
      end
    end

    describe '#loaded?' do
      subject { @model.loaded? }

      context 'when model is not loaded' do
        it { expect(@model.loaded?).to be_falsey }
      end

      context 'when model is already loaded' do
        before do
          allow(@model).to \
            receive_message_chain(:load_model, :attributes).and_return({})
          @model.load
        end
        it { expect(subject).to be_truthy }
      end
    end

    describe '#reload' do
      subject { @model.reload }

      context 'when load successfully' do
        before do
          allow(@model).to \
            receive_message_chain(:load_model, :attributes).and_return({})
          @model.load
        end
        it { expect(subject).to be_truthy }
      end

      context 'when load failed' do
        before do
          allow(@model).to receive(:load_model).and_raise(ArgumentError)
        end

        it { expect(subject).to be_falsey }
      end
    end
  end
end
