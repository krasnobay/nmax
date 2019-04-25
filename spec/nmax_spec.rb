require 'json'

RSpec.describe Nmax do
  it 'has a version number' do
    expect(Nmax::VERSION).not_to be nil
  end

  data = JSON.parse(
    File.read('spec/fixtures/params_numbers.json'),
    symbolize_names: true
  )

  data.each do |test|
    describe test[:file] do
      before(:each) do
        @stream = File.open("spec/fixtures/#{test[:file]}", 'r')
      end

      after(:each) do
        @stream.close
      end

      it 'checking search maximum' do
        numbers = Nmax.call @stream, test[:request_count]
        expect(numbers).to eq(test[:answer])
      end

      it 'checking count result' do
        numbers = Nmax.call @stream, test[:request_count]
        expect(numbers.length).to eq(test[:answer_count])
      end
    end
  end
end
