class Activity < ActiveRecord::Base
  attr_accessible :name, :whichtype
  has_many :logs

  def stats
    time = Time.new
    logger.debug '----------------------------------------------'
    logger.debug self.logs
    logger.debug time.day
    logger.debug '----------------------------------------------'
  end

  def legal_logs
    # Needed to add this as opposed to just "@activity.logs"
    # because it was conflicting with a "Log.new" call.
    return self.logs.where('activity_id IS NOT NULL')
  end
end


