require 'rails_helper'

RSpec.describe PrepareParamsAfterEnterSubcategoryBeforeSave do
  subject { described_class.call(telegram_message) }

  let(:telegram_message) do
    "Полуфабрикаты/м_: f1_id:1234567890123456:2.99"
  end
  let(:redis) { Redis.new }

  before do
    redis.set("1234567890123456", redis_params, ex: 10.seconds)
  end

  context 'when uah' do
    let(:redis_params) { "[{\"price\":2.65,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26582]},{\"price\":2.85,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26583]},{\"price\":1.55,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26584]},{\"price\":1.75,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26585]},{\"price\":3.35,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26586]},{\"price\":1.2,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26587]},{\"price\":1.09,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26588]},{\"price\":0.6,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26589]},{\"price\":1.29,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26590]},{\"price\":5.5,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26591]},{\"price\":2.03,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26592]},{\"price\":2.73,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26593]},{\"price\":2.99,\"currency_to_usd\":null,\"currency_to_uah\":45.46,\"message_ids\":[26594,26594],\"category_name\":\"Еда\"}]" }

    before do
      allow(MonobankCurrencyRates).to receive(:call).with('USD', 'UAH').and_return(37.4995)
    end

    it 'returns 3 values' do
      expect(subject).to eq(
        [
          {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :operation_amount=>2.99, :price_in_uah=>3.624725663008841},
          [
            {"price"=>2.65, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26582]},
            {"price"=>2.85, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26583]},
            {"price"=>1.55, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26584]},
            {"price"=>1.75, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26585]},
            {"price"=>3.35, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26586]},
            {"price"=>1.2,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26587]},
            {"price"=>1.09, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26588]},
            {"price"=>0.6,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26589]},
            {"price"=>1.29, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26590]},
            {"price"=>5.5,  "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26591]},
            {"price"=>2.03, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26592]},
            {"price"=>2.73, "currency_to_usd"=>nil, "currency_to_uah"=>45.46, "message_ids"=>[26593]}
          ],
          [26594, 26594]
        ]
      )
    end
  end

  context 'when usd' do
    let(:redis_params) { "[{\"price\":2.65,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26582]},{\"price\":2.85,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26583]},{\"price\":1.55,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26584]},{\"price\":1.75,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26585]},{\"price\":3.35,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26586]},{\"price\":1.2,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26587]},{\"price\":1.09,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26588]},{\"price\":0.6,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26589]},{\"price\":1.29,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26590]},{\"price\":5.5,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26591]},{\"price\":2.03,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26592]},{\"price\":2.73,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26593]},{\"price\":2.99,\"currency_to_usd\":0.8707,\"currency_to_uah\":null,\"message_ids\":[26594,26594],\"category_name\":\"Еда\"}]" }

    it 'returns 3 values' do
      expect(subject).to eq(
        [
          {:category_name=>"Еда", :sub_category_name=>"Полуфабрикаты/морозилка", :operation_amount=>2.99, :price_in_usd=>3.4340186057195363},
          [
            {"price"=>2.65, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26582]},
            {"price"=>2.85, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26583]},
            {"price"=>1.55, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26584]},
            {"price"=>1.75, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26585]},
            {"price"=>3.35, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26586]},
            {"price"=>1.2,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26587]},
            {"price"=>1.09, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26588]},
            {"price"=>0.6,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26589]},
            {"price"=>1.29, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26590]},
            {"price"=>5.5,  "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26591]},
            {"price"=>2.03, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26592]},
            {"price"=>2.73, "currency_to_usd"=>0.8707, "currency_to_uah"=>nil, "message_ids"=>[26593]}
          ],
          [26594, 26594]
        ]
      )
    end
  end
end
