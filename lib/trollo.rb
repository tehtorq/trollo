require "active_record"
require "workflow"
require "acts_as_commentable"
require "trollo/version"

module Trollo
    
  def self.table_name_prefix
    'trollo_'
  end
    
end

require "trollo/troller"
require "trollo/card"
require "trollo/list"
require "trollo/board"
require "trollo/task"
require "trollo/tasklist"
require "trollo/subscription"
require "trollo/label"
