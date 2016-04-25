module Uphold
  module API
    module Voucher
      # def all_vouchers
      #   Request.perform_with_objects(:get, vouchers_request_data)
      # end
      #
      # def find_voucher(id: nil)
      #   Request.perform_with_object(:get, voucher_request_data(id))
      # end

      def create_voucher(
        card_id:,
        program_id: nil,
        amount:,
        currency:,
        redeemer_fee: nil,
        issuer_fee: nil,
        intended_beneficiary:
      )
        opts = {
          CardId: card_id,
          # program_id: program_id,
          amount: amount,
          currency: currency,
          redeemerFee: redeemer_fee,
          issuerFee: issuer_fee,
          intendedBeneficiary: intended_beneficiary,
        }
        puts opts
        request_data = vouchers_request_data(opts)
        Request.perform_with_object(:post, request_data)
      end

      private

      def vouchers_request_data(payload = nil)
        RequestData.new(
          Endpoints::VOUCHER,
          Entities::Voucher,
          authorization_header,
          payload
        )
      end

      # def voucher_request_data(id)
      #   RequestData.new(
      #     Endpoints::VOUCHER + "/#{id}",
      #     Entities::Voucher,
      #     authorization_header
      #   )
      # end
    end
  end
end
