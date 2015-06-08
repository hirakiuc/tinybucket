require 'spec_helper'

RSpec.describe Tinybucket::NullLogger do
  subject { Tinybucket::NullLogger.new }

  describe '#level' do
    it { expect(subject).to respond_to(:level) }
  end

  describe '#level=' do
    it { expect(subject).to respond_to(:level=) }
  end

  describe '#fatal' do
    it { expect(subject).to respond_to(:fatal) }
  end

  describe '#fatal?' do
    it { expect(subject.fatal?).to be_falsey }
  end

  describe '#error' do
    it { expect(subject).to respond_to(:error) }
  end

  describe '#error?' do
    it { expect(subject.error?).to be_falsey }
  end

  describe '#warn' do
    it { expect(subject).to respond_to(:warn) }
  end

  describe '#warn?' do
    it { expect(subject.warn?).to be_falsey }
  end

  describe '#info' do
    it { expect(subject).to respond_to(:info) }
  end

  describe '#info?' do
    it { expect(subject.info?).to be_falsey }
  end

  describe '#debug' do
    it { expect(subject).to respond_to(:debug) }
  end

  describe '#debug?' do
    it { expect(subject.debug?).to be_falsey }
  end
end
