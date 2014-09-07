module ModelMacros
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
