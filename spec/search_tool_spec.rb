require_relative '../search_tool'

describe 'start_application' do
  let(:expected_respones) do
    {
      expect: 'response'
    }
  end

  let(:commands_handler_stub) do
    instance_double(CommandsHandler, 'CommandsHandlerStub',
                    intial_state: 1,
                    select_search_term: '',
                    select_type_of_search: 2,
                    select_search_value: '')
  end

  let(:parse_data_stub) do
    instance_double(ParseData, 'ParseDataStub',
                    get_keys: '',
                    search_for_value: expected_respones)
  end

  let(:report_outcome_stub) do
    instance_double(ReportOutcome, 'ReportOutcomeStub',
                    print: '',
                    print_all_keys_in_table: '')
  end

  before do
    allow(CommandsHandler).to receive(:new).and_return(commands_handler_stub)
    allow(ParseData).to receive(:new).and_return(parse_data_stub)
    allow(ReportOutcome).to receive(:new).and_return(report_outcome_stub)
  end

  describe 'Given that user choses to search Zen desk' do
    it 'calls the questions and get the data for questions in the correct order' do
      start_application

      expect(commands_handler_stub).to have_received(:select_type_of_search).ordered
      expect(parse_data_stub).to have_received(:get_keys).ordered
      expect(commands_handler_stub).to have_received(:select_search_term).ordered
      expect(commands_handler_stub).to have_received(:select_search_value).ordered
      expect(parse_data_stub).to have_received(:search_for_value).ordered
    end
    it 'prints the returned search result' do
      start_application
      expect(report_outcome_stub)
        .to have_received(:print).with(expected_respones).once
    end
  end

  describe 'Given that user choses to view a list of searchable fields' do

    before do
      allow(commands_handler_stub).to receive(:intial_state).and_return(2)
    end

    it 'prints all keys' do
      start_application
      expect(report_outcome_stub)
        .to have_received(:print_all_keys_in_table).once
    end
  end
end
