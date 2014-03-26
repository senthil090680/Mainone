class BranchDetail < ActiveRecord::Base
  
  set_table_name "BRANCH_MASTER"
 
  alias_attribute :name, :branch_name
  alias_attribute :code, :branch_code
    
  attr_accessible :name ,:code


end
