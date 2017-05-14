require 'spec_helper'
require 'ostruct'

RSpec.describe HashMangler::Mangler do
  describe '#mangle' do
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

    context 'no value_mangler proc provided' do
      subject { HashMangler::Mangler.new.mangle(test_hash) }

      it 'mangle works', :aggregate_failures do
        expect(subject.a.b).to eq(test_hash[:a][:b])
        expect(subject.c).to be_a(Array)
        expect(subject.c[0].d.e).to eq(test_hash[:c][0][:d][:e])
        expect(subject.c[1].f).to eq(test_hash[:c][1][:f])
        expect(subject.c[2]).to eq(test_hash[:c][2])
        expect(subject.camel_case_name).to eq(test_hash[:camelCaseName])
      end

      it 'raises NoMethodError when wrong method name is provided' do
        expect { subject.a.c }.to raise_error(NoMethodError)
      end
    end

    context 'value_mangler proc provided' do
      let(:value_mangler) { proc { |o| o.to_s.upcase } }
      let(:options) { { value_mangler: value_mangler } }
      subject { HashMangler::Mangler.new(options).mangle(test_hash) }

      it 'mangle works', :aggregate_failures do
        expect(subject.a.b).to eq(value_mangler.(test_hash[:a][:b]))
        expect(subject.c).to be_a(Array)
        expect(subject.c[0].d.e).to eq(value_mangler.(test_hash[:c][0][:d][:e]))
        expect(subject.c[1].f).to eq(value_mangler.(test_hash[:c][1][:f]))
        expect(subject.c[2]).to eq(value_mangler.(test_hash[:c][2]))
        expect(subject.camel_case_name).to eq(value_mangler.(test_hash[:camelCaseName]))
      end

      it 'raises NoMethodError when wrong method name is provided' do
        expect { subject.a.c }.to raise_error(NoMethodError)
      end
    end

    context 'snake_case_method_names option provided' do
      let(:options) { { snake_case_method_names: false } }
      subject { HashMangler::Mangler.new(options).mangle(test_hash) }

      it 'mangle works', :aggregate_failures do
        expect(subject.a.b).to eq(test_hash[:a][:b])
        expect(subject.c).to be_a(Array)
        expect(subject.c[0].d.e).to eq(test_hash[:c][0][:d][:e])
        expect(subject.c[1].f).to eq(test_hash[:c][1][:f])
        expect(subject.c[2]).to eq(test_hash[:c][2])
        expect(subject.camelCaseName).to eq(test_hash[:camelCaseName])
      end

      it 'raises NoMethodError when wrong method name is provided' do
        expect { subject.camel_case_name }.to raise_error(NoMethodError)
      end
    end

    context 'Hash as struct_class' do
      let(:value_mangler) { proc { |o| o.to_s.upcase } }
      let(:options) { { struct_class: Hash, value_mangler: value_mangler } }
      subject { HashMangler::Mangler.new(options).mangle(test_hash) }

      it 'mangle works', :aggregate_failures do
        expect(subject[:a][:b]).to eq(value_mangler.(test_hash[:a][:b]))
        expect(subject[:c]).to be_a(Array)
        expect(subject[:c][0][:d][:e]).to eq(value_mangler.(test_hash[:c][0][:d][:e]))
        expect(subject[:c][1][:f]).to eq(value_mangler.(test_hash[:c][1][:f]))
        expect(subject[:c][2]).to eq(value_mangler.(test_hash[:c][2]))
        expect(subject[:camel_case_name]).to eq(value_mangler.(test_hash[:camelCaseName]))
      end

      it 'raises NoMethodError when wrong method name is provided' do
        expect { subject.camel_case_name }.to raise_error(NoMethodError)
      end
    end

    context 'OpenStruct as struct_class' do
      let(:value_mangler) { proc { |o| o.to_s.upcase } }
      let(:options) { { struct_class: OpenStruct, value_mangler: value_mangler } }
      subject { HashMangler::Mangler.new(options).mangle(test_hash) }

      it 'mangle works', :aggregate_failures do
        expect(subject.a.b).to eq(value_mangler.(test_hash[:a][:b]))
        expect(subject.c).to be_a(Array)
        expect(subject.c[0].d.e).to eq(value_mangler.(test_hash[:c][0][:d][:e]))
        expect(subject.c[1].f).to eq(value_mangler.(test_hash[:c][1][:f]))
        expect(subject.c[2]).to eq(value_mangler.(test_hash[:c][2]))
        expect(subject.camel_case_name).to eq(value_mangler.(test_hash[:camelCaseName]))
      end

      it 'raises NoMethodError when wrong method name is provided' do
        expect(subject.a.c).to eq(nil)
      end
    end
  end
end
