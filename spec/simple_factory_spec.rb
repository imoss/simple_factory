require "spec_helper"

describe SimpleFactory do
  describe '.simple_factory' do
    let(:foo) do
      class Foo
        include SimpleFactory

        simple_factory :say, :naysay

        def initialize(bar, baz)
          @bar, @baz = bar, baz
        end

        def say
          "#{@bar} and #{@baz}"
        end

        def naysay
          "neither #{@bar} nor #{@baz}"
        end
      end
      Foo
    end

    it { expect(foo).to respond_to(:say) }
    it { expect(foo).to respond_to(:naysay) }
    it { expect(foo.say('this', 'that')).to eq(foo.new('this', 'that').say) }
    it { expect(foo.naysay('this', 'that')).to eq(foo.new('this', 'that').naysay) }
    it { expect(foo.say('this', 'that')).to eq('this and that') }
    it { expect(foo.naysay('this', 'that')).to eq('neither this nor that') }
  end

  it 'has a version' do
    expect(SimpleFactory::VERSION).not_to be_nil
  end
end
