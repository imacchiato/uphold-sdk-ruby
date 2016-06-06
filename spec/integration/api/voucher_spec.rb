require 'spec_helper'

module Uphold
  module API
    describe Contact do
      let(:client) { Uphold::Client.new(token: CONFIG[:token]) }
      let(:card_id) { CONFIG[:card_id] }

      context '#create_voucher' do
        it 'issues a voucher' do
          VCR.use_cassette('vouchers/created_voucher') do
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
            expect(voucher).to be_pending
          end
        end
      end

      context '#commit_voucher' do
        let(:card_id) { CONFIG[:card_id] }

        it 'commits a specific voucher' do
          VCR.use_cassette("vouchers/comitted_voucher") do
            created_voucher = client.create_voucher(
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

            voucher = client.commit_voucher(created_voucher.id)

            expect(voucher).to be_a(Entities::Voucher)
            expect(voucher).to be_ready
          end
        end
      end

      context '#find_voucher' do
        it 'gets a specific voucher' do
          let(:card_id) { CONFIG[:card_id] }

          VCR.use_cassette("vouchers/voucher") do
            created_voucher = client.create_voucher(
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

            voucher = client.find_voucher(created_voucher.id)
            expect(voucher).to be_a(Entities::Voucher)
            expect(voucher.id).to eq created_voucher.id
            expect(voucher.amount).to eq 1.0
          end
        end
      end

      context '#cancel_voucher' do
        it 'cancels a specific voucher' do
          let(:card_id) { CONFIG[:card_id] }

          VCR.use_cassette("vouchers/canceled_voucher") do
            created_voucher = client.create_voucher(
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

            voucher = client.cancel_voucher(created_voucher.id)
            expect(voucher).to be_a(Entities::Voucher)
            expect(voucher.id).to be_cancelled
          end
        end
      end

      context '#redeem_voucher' do
        it 'redeems a specific voucher' do
          let(:card_id) { CONFIG[:card_id] }

          VCR.use_cassette("vouchers/redeemed_voucher") do
            created_voucher = client.create_voucher(
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

            voucher = client.redeem_voucher(created_voucher.id)
            expect(voucher).to be_a(Entities::Voucher)
            expect(voucher.id).to be_redeemled
          end
        end
      end

      context '#revert_voucher' do
        it 'reverts a specific voucher' do
          let(:card_id) { CONFIG[:card_id] }

          VCR.use_cassette("vouchers/reverted_voucher") do
            created_voucher = client.create_voucher(
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

            voucher = client.revert_voucher(created_voucher.id)
            expect(voucher).to be_a(Entities::Voucher)
            expect(voucher.id).to be_ready
          end
        end
      end

    end
  end
end

