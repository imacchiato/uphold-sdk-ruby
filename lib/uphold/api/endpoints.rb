module Uphold
  module Endpoints
    AUTH = '/me/tokens'
    CARD = '/me/cards'
    CARD_PRIVATE_TRANSACTIONS = CARD + '/:card/transactions'
    CREATE_AND_COMMIT_TRANSACTION = CARD_PRIVATE_TRANSACTIONS + '?commit=true'
    COMMIT_TRANSACTION = CARD_PRIVATE_TRANSACTIONS + '/:id/commit'
    CANCEL_TRANSACTION = CARD_PRIVATE_TRANSACTIONS + '/:id/cancel'
    RESEND_TRANSACTION = CARD_PRIVATE_TRANSACTIONS + '/:id/resend'
    USER_PRIVATE_TRANSACTIONS = '/me/transactions'
    PUBLIC_TRANSACTIONS = '/reserve/transactions'
    LEDGER = '/reserve/ledger'
    STATS = '/reserve/statistics'
    TICKER = '/ticker'
    USER = '/me'
    USER_CONTACTS = '/me/contacts'
    USER_PHONES = '/me/phones'
    VOUCHER = '/vouchers'

    def self.with_placeholders(endpoint, substitutions = {})
      new_endpoint = endpoint.dup
      substitutions.each_pair do |placeholder, substitute|
        new_endpoint.gsub!(placeholder, substitute)
      end
      new_endpoint
    end
  end
end
