require "active_record"
require "workflow"
require "trollo/version"

module Trollo
    
  def self.table_name_prefix
    'trollo_'
  end
    
end

require "trollo/card"
require "trollo/list"
require "trollo/task"
require "trollo/tasklist"
require "trollo/troller"
