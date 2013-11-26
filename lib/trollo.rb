require "active_record"
require "workflow"
require "trollo/version"

module Trollo
    
  def self.table_name_prefix
    'trollo_'
  end
    
end

require "trollo/exception"
require "trollo/invoiceable"
require "trollo/transaction"
require "trollo/credit_transaction"
require "trollo/debit_transaction"
require "trollo/late_payment"
require "trollo/line_item"
require "trollo/payment_reference"
require "trollo/seller"
require "trollo/buyer"
require "trollo/invoice_decorator"
require "trollo/credit_note_invoice"
require "trollo/credit_note_credit_transaction"

require "trollo/invoice"
require "trollo/credit_note"
require "trollo/overdue_invoice"
require "trollo/invoice_adjustment"
require "trollo/line_item_type"
