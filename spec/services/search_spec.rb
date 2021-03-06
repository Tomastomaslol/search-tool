require_relative '../../services/search'

describe Search do
  let(:example_picked_type_data) do
    [
      {
        '_id' => 101,
        'name' => 'Mr Name McName',
        'active' => true,
        'url' => 'http://initech.zendesk.com/api/v2/organizations/101.json',
        'tags' => %w[
          lamp
          desk
        ]
      },
      {
        '_id' => 102,
        'name' => 'Mr Test Nameson',
        'active' => true,
        'url' => 'http://initech.zendesk.com/api/v2/organizations/102.json',
        'tags' => %w[
          chair
          desk
        ]
      }
    ]
  end

  let(:unexpected_string_in_example_picked_type_data) do
    ['unexpected string'] + example_picked_type_data
  end

  let(:example_search_term) { 'name' }
  let(:example_search_value) { 'mr' }

  context 'Given valid data' do
    context 'Given that feature slightly smarter search is true' do
      before do
        allow_any_instance_of(described_class)
          .to receive(:SLIGHTLY_SMARTER_SEARCH) { false }
      end

      describe 'initialize' do
        it 'initialises a valid instance of search' do
          expect(described_class.new(example_picked_type_data,
                                     example_search_term, example_search_value))
            .to be_an_instance_of described_class
        end
      end

      describe '#find_matching_terms' do
        it 'returns a search result if there is a full string match' do
          expect(described_class.new(example_picked_type_data,
                                     '_id', '101').find_matching_terms)
            .to eq [example_picked_type_data[0]]
        end

        it 'returns all partial matching strings search results' do
          expect(described_class.new(example_picked_type_data,
                                     'name', 'mr').find_matching_terms)
            .to eq [example_picked_type_data[0], example_picked_type_data[1]]
        end

        it 'ignores casing when matching' do
          expect(described_class.new(
            example_picked_type_data, 'name', 'mr naME mcnaMe'
          ).find_matching_terms)
            .to eq [example_picked_type_data[0]]
        end

        it 'returns 0 search results if there is no matches' do
          expect(described_class.new(example_picked_type_data, 'active', false)
            .find_matching_terms).to eq []
        end

        it 'returns a search result if there is a matching tag' do
          expect(described_class.new(example_picked_type_data, 'tags', 'lamp')
            .find_matching_terms).to eq [example_picked_type_data[0]]
        end

        it 'returns 2 search results if there are 2 matching tags' do
          expect(described_class.new(example_picked_type_data, 'tags', 'desk')
            .find_matching_terms).to eq [example_picked_type_data[0],
                                         example_picked_type_data[1]]
        end

        it 'returns 2 search results if there are 2 partially matching tags' do
          expect(described_class.new(example_picked_type_data, 'tags', 'des')
            .find_matching_terms)
            .to eq [example_picked_type_data[0], example_picked_type_data[1]]
        end

        it 'returns 0 search results if there is no matching tag' do
          expect(described_class.new(example_picked_type_data, 'tags',
                                     'there is no match for this tag')
            .find_matching_terms)
            .to eq []
        end
      end
    end
  end

  context 'Given that feature slightly smarter search is false' do

    before do
      allow_any_instance_of(described_class)
        .to receive(:SLIGHTLY_SMARTER_SEARCH) { false }
    end

    describe '#search_for_value' do
      it 'returns a search result if there is a match' do
        expect(described_class.new(example_picked_type_data, '_id', '101')
          .find_matching_terms).to eq [example_picked_type_data[0]]
      end

      it 'returns 2 search results if there are 2 matches' do
        expect(described_class.new(example_picked_type_data, 'active', true)
          .find_matching_terms).to eq example_picked_type_data
      end

      it 'returns 0 search results if there are no matches' do
        expect(described_class.new(example_picked_type_data, 'active', false)
          .find_matching_terms).to eq []
      end
    end
  end

  context 'Given invalid input data' do
    describe 'initialize' do
      it 'raises an exception when given a string as parsed response' do
        expect do
          described_class.new('unexpected string',
                              example_search_term, example_search_value)
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given array has no hash included in parsed response' do
        expect do
          described_class.new(unexpected_string_in_example_picked_type_data,
                              example_search_term, example_search_value)
        end.to raise_exception RuntimeError
      end

      it 'raises an exception when given a non string for search term' do
        expect do
          described_class.new(example_picked_type_data, [], example_search_value)
        end.to raise_exception RuntimeError
      end
    end
  end
end
