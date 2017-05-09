require "spec_helper"

RSpec.describe HashMangler::Mangler do
  describe '#mangle' do
    let(:test_hash) do
      {
        a: { b: 1 },
        c: [ { d: { e: '2' } }, { f: 'g' }, 'h' ],
        camelCaseName: 'j'
      }
    end

    it "mangle works", :aggregate_failures do
      mangled = HashMangler::Mangler.new.mangle(test_hash)
      expect(mangled.a.b).to eq(test_hash[:a][:b])
      expect(mangled.c).to be_a(Array)
      expect(mangled.c[0].d.e).to eq(test_hash[:c][0][:d][:e])
      expect(mangled.c[1].f).to eq(test_hash[:c][1][:f])
      expect(mangled.c[2]).to eq(test_hash[:c][2])
      expect(mangled.camel_case_name).to eq(test_hash[:camelCaseName])
    end
  end
end
