require_relative '../../services/report_outcome'

describe ReportOutcome do

  let(:example_config) do
    {
      indent: 99
    }
  end

  let(:example_default_config) do
    {
      indent: 111
    }
  end

  context 'Given no config' do
    describe 'initialize' do

      before(:each) do
        allow_any_instance_of(described_class).to receive(:default_config) { example_default_config }
      end

      it 'initialises a valid instance of report outcome' do
        expect(described_class.new).to be_an_instance_of described_class
      end

      it 'sets given valid config' do
        expect(described_class.new()
          .instance_variable_get(:@config)).to be example_default_config
      end
    end
  end

  context 'Given config' do
    describe 'initialize' do
      it 'initialises a valid instance of report outcome' do
        expect(described_class.new(example_config)).to be_an_instance_of described_class
      end

      it 'sets given valid config' do
        expect(described_class.new(example_config)
          .instance_variable_get(:@config)).to be example_config
      end
    end
  end
end
