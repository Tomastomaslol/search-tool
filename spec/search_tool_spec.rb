require_relative '../search_tool'

describe 'start_application' do
  let(:expected_response) do
    {
      expect: 'response'
    }
  end

  let(:commands_handler_stub) do
    instance_double(CommandsHandler, 'CommandsHandlerStub',
                    initial_state: 1,
                    select_search_term: '',
                    select_type_of_search: 2,
                    select_search_value: '',
                    re_run_application?: false)
  end

  let(:data_handler_stub) do
    instance_double(DataHandler, 'DataHandlerStub',
                    get_keys: '',
                    get_all: '')
  end

  let(:report_outcome_stub) do
    instance_double(ReportOutcome, 'ReportOutcomeStub',
                    print_search_results: '',
                    print_all_searchable_keys_and_headlines: '')
  end

  let(:search_stub) do
    instance_double(Search, 'SearchStub',
                    find_matching_terms: expected_response)
  end

  before do
    allow(CommandsHandler).to receive(:new).and_return(commands_handler_stub)
    allow(DataHandler).to receive(:new).and_return(data_handler_stub)
    allow(ReportOutcome).to receive(:new).and_return(report_outcome_stub)
    allow(Search).to receive(:new).and_return(search_stub)
    allow(Kernel).to receive(:exit).and_return('')
  end

  describe 'Given that the user picks the option to search Zendesk' do
    it 'invokes the methods to show the questions and gets the data for the questions in the correct order' do
      start_application

      expect(commands_handler_stub).to have_received(:select_type_of_search).ordered
      expect(data_handler_stub).to have_received(:get_keys).ordered
      expect(commands_handler_stub).to have_received(:select_search_term).ordered
      expect(commands_handler_stub).to have_received(:select_search_value).ordered
      expect(data_handler_stub).to have_received(:get_all).ordered
      expect(search_stub).to have_received(:find_matching_terms).ordered
    end

    it 'prints the returned search result' do
      start_application
      expect(report_outcome_stub)
        .to have_received(:print_search_results).with(expected_response).once
    end

    it 'asks the user if they would like to run the application again' do
      start_application
      expect(commands_handler_stub)
        .to have_received(:re_run_application?).once
    end
  end

  describe 'Given that the user picks the option to view a list of searchable fields' do
    before do
      allow(commands_handler_stub).to receive(:initial_state).and_return(2)
    end

    it 'prints all keys' do
      start_application
      expect(report_outcome_stub)
        .to have_received(:print_all_searchable_keys_and_headlines).once
    end

    it 'asks the user if they would like to run the application again' do
      start_application
      expect(commands_handler_stub)
        .to have_received(:re_run_application?).once
    end
  end
end
