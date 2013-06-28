class Log < ActiveRecord::Base
  attr_accessible :checkmark, :count, :fordate, :whichtype, :activity_id
  belongs_to :activity

  # Equivalent to [below] but wanted to try it out myself.
  # validates :activity_id, :presence => true
  before_validation :activity_id_exists
  def activity_id_exists
    return false if self.activity_id.nil?
  end

  def past_logs
    limit = 5
    # pull past 5 logs before today's date
    # order by date
    # grab last 6 then reject today's
  end
  
  # Basically an existing entry clobber.
  before_save do
    logs = Activity.find(self.activity_id).logs #.map { |log| log.fordate.to_s }

    found_duplicate = nil
    duplicate_id = nil

    logs.each { |log|
      if self.fordate.to_s == log.fordate.to_s and log.id != self.id
        found_duplicate = true
        duplicate_id = log.id
      end
    }

    unless found_duplicate.nil?
      logger.debug 'Duplicate Found. ########'
      duplicate = Log.find(duplicate_id)
      whichtype = duplicate.whichtype
      duplicate.destroy
    end
  end
  
  after_save :update_fordate
  def update_fordate
    if self.fordate.nil?
      # "if" loop prevents recursion.
      self.update_attributes(:fordate => self.created_at.to_s.split(' ')[0])
      self.save
    end
  end
end
