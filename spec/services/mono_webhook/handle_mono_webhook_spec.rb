require 'rails_helper'

RSpec.describe MonoWebhook::HandleMonoWebhook do
  subject{ described_class.call(params) }

  context 'when fop dollar card' do
    let(:params) do
      {
        "type" => "StatementItem",
        "data" => {
          "account" => "IJ8Y_c1UAwxRHa4vAlTivQ",
          "statementItem" => statement_item,
        }
      }
    end
    let(:statement_item) do
      {
        "id" => "tk6Ulh_sMFs9e_Zt",
        "time" => 1661599923,
        "description" => "McDonald’s",
        "mcc" => 5814,
        "originalMcc" => 5814,
        "amount" => -923,
        "operationAmount" => -775,
        "currencyCode" => 826,
        "commissionRate" => 0,
        "cashbackAmount" => 0,
        "balance" => 1550167,
        "hold" => true,
        "receiptId" => "140P-2T0E-E2X6-2HX3"
      }
    end
    let(:symbolized_statement_item) do
      statement_item.deep_symbolize_keys
    end

    it 'calls MonoWebhook::EnterExpencesFopDollarCardFromWebhook' do
      expect(MonoWebhook::EnterExpencesFopDollarCardFromWebhook).to receive(:call).with(symbolized_statement_item)

      subject
    end
  end

  context 'when uah black card' do
    let(:params) do
      {
        "type" => "StatementItem",
        "data" => {
          "account" => "C0Hfjf2vrc00CZ_1ZCjSLg",
          "statementItem" => statement_item,
        }
      }
    end
    let(:statement_item) do
      {
        "id" => "nr1t_orz5adGZB-X",
        "time" => 1661346889,
        "description" => "Частичное снятие банки «На награду в моно»",
        "mcc" => 4829,
        "originalMcc" => 4829,
        "amount" => 10000,
        "operationAmount" => 10000,
        "currencyCode" => 980,
        "commissionRate" => 0,
        "cashbackAmount" => 0,
        "balance" => 2927000,
        "hold" => true
      }
    end
    let(:symbolized_statement_item) do
      statement_item.deep_symbolize_keys
    end

    it 'calls MonoWebhook::EnterExpencesUahBlackCardFromWebhook' do
      expect(MonoWebhook::EnterExpencesUahBlackCardFromWebhook).to receive(:call).with(symbolized_statement_item)

      subject
    end
  end
end
