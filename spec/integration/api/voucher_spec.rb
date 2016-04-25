require 'spec_helper'

module Uphold
  module API
    describe Contact do
      let(:client) do
        # TODO put this in config.
        Uphold::Client.new(token: "f140a4c49012136d31a44322cef45b6228f1ed99")
      end

      context '#create_voucher' do
        it 'issues a voucher' do
          VCR.use_cassette('vouchers/created_voucher') do
            # TODO put this in a config? Card w/ funds...
            card_id = "043f156b-31c7-41f8-a4e7-d30a41c07ca7"

            voucher = client.create_voucher(
              card_id: card_id,
              # program_id: "great-program",
              amount: 1.0,
              currency: "USD",
              redeemer_fee: 0.25,
              issuer_fee: 0.1,
              intended_beneficiary: {
                first_name: "Jose",
                last_name: "Sanchez Avila",
                country: "MX",
                state: "Mexico City",
              },
            )

            expect(voucher).to be_a(Entities::Voucher)
          end
        end
      end
      #
      # context '#create_contact' do
      #   it 'creates a contact' do
      #     VCR.use_cassette('me/created_contact') do
      #       data = {
      #         first_name: 'first-name',
      #         last_name: 'last-name',
      #         emails: ['fake@email.com'],
      #         company: 'company-name',
      #         addresses: []
      #       }
      #
      #       contact = client.create_contact(data)
      #
      #       expect(contact).to be_a(Entities::Contact)
      #       expect(contact.first_name).to eq(data[:first_name])
      #     end
      #   end
      # end
    end
  end
end

