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

  let(:data_handler_stub) do
    instance_double(DataHandler, 'DataHandlerStub',
                    get_type: 'user',
                    get_keys: ['example key1', 'example key2'])
  end

  let(:all_data_handlers) { [data_handler_stub, data_handler_stub] }

  let(:example_print_output) { [{ 'a': 'b' }] }

  context 'Given no config' do
    describe 'initialize' do
      before do
        allow_any_instance_of(described_class)
          .to receive(:default_config) { example_default_config }
      end

      it 'initialises a valid instance of report outcome' do
        expect(described_class.new).to be_an_instance_of described_class
      end

      it 'sets config to default config' do
        expect(described_class.new
          .instance_variable_get(:@config)).to be example_default_config
      end
    end

    describe '#print_all_keys_in_table' do
      before do
        allow(Kernel).to receive(:print).and_return('')
      end

      subject { described_class.new }

      it 'prints given table headers to the system' do
        subject.print_all_keys_in_table(all_data_handlers)
        expect(Kernel).to have_received(:print).with(/User/).twice
      end

      it 'prints given table keys to the system' do
        subject.print_all_keys_in_table(all_data_handlers)
        expect(Kernel).to have_received(:print).with(/example key1/).twice
      end
    end
    describe '#print' do
      before do
        allow(Kernel).to receive(:print).and_return(nil)
        allow_any_instance_of(described_class)
          .to receive(:print_output).and_return(nil)
      end

      subject { described_class.new }

      it "prints a 'no search results' message to system if given an empty object" do
        subject.print([])
        expect(Kernel).to have_received(:print)
          .with(/No search results found/).once
      end

      it "does not print a 'no search results' message to system if given an valid object" do
        subject.print(example_print_output)
        expect(Kernel).to_not have_received(:print)
      end

      it 'prints given data if given a none empty array' do
        subject.print(example_print_output)
        expect(subject).to have_received(:print_output)
          .with(example_print_output).once
      end
    end
  end

  context 'Given config' do
    describe 'initialize' do
      it 'initialises a valid instance of report outcome' do
        expect(described_class.new(example_config))
          .to be_an_instance_of described_class
      end

      it 'sets config to given valid config' do
        expect(described_class.new(example_config)
          .instance_variable_get(:@config)).to be example_config
      end
    end
  end
end
