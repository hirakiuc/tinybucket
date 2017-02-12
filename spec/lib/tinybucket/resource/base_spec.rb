require 'spec_helper'

class TestResource < Tinybucket::Resource::Base
  def enumerator
    (0..10).to_a.to_enum
  end
end

RSpec.describe Tinybucket::Resource::Base do
  let(:resource) { TestResource.new }

  describe 'respond_to?' do
    context 'with undefined method call' do
      subject { resource.respond_to?(:undefined_method_call) }
      it 'should raise NoMethodError' do
        expect(subject).to eq(false)
      end
    end
  end
end
