class Payment < ActiveRecord::Base
  belongs_to :loan
end
