require 'rails_helper'

RSpec.describe HandleInputPhotoJob do
  subject { described_class.perform_later(message_params) }

  let(:message_params) do
    {
      id: 123
    }
  end
  it 'calls HandleInputPhoto' do
    expect(HandleInputPhoto).to receive(:call).with(message_params)

    perform_enqueued_jobs { subject }
  end
end
