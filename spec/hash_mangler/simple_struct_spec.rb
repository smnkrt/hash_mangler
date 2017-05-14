require 'spec_helper'
require 'json'

RSpec.describe HashMangler::SimpleStruct do
  let(:test_value) { 'sample_value' }
  subject { described_class.new }
  describe '#[], #[]= methods' do
    it :aggregate_failures do
      s = subject
      s[:test_hash] = test_value
      expect(s.test_hash).to eq(test_value)
      expect(s[:test_hash]).to eq(test_value)
    end
  end

  context 'can be used with JSON.parse' do
    let(:test_hash) do
      {
        a: { b: 1 },
        c: [
          { d: { e: '2' } },
          { f: 'g' },
          'h'
        ],
        camelCaseName: 'j'
      }
    end

    let(:test_json) { test_hash.to_json }

    subject { JSON.parse(test_json, object_class: described_class) }
    it do
      expect(subject.a.b).to eq(test_hash[:a][:b])
      expect(subject.c).to be_a(Array)
      expect(subject.c[0].d.e).to eq(test_hash[:c][0][:d][:e])
      expect(subject.c[1].f).to eq(test_hash[:c][1][:f])
      expect(subject.c[2]).to eq(test_hash[:c][2])
      expect(subject.camelCaseName).to eq(test_hash[:camelCaseName])
    end
  end
end
