class Log < ActiveRecord::Base
  attr_accessible :checkmark, :count, :fordate, :whichtype, :activity_id
  belongs_to :activity

  before_validation :activity_id_exists
  def activity_id_exists
    return false if self.activity_id.nil?
  end
  # Equivalent to [below] but wanted to try it out myself.
  # validates :activity_id, :presence => true
  
  def legal_logs
  end
end
