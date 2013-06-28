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

  def today_log
    time = Time.now
    year = time.year
    month = time.month
    day = time.day
    self.logs.where("fordate = #{year}-#{month}-#{day}")
  end

  def ordered_logs
    ordered_logs = self.logs.order('fordate')
  end

  def past_logs
    limit = 4
    ordered_logs = self.ordered_logs
    ordered_logs.length-1-limit < 0 ? start_index = 0 : start_index = ordered_logs.length-1-limit
    ordered_logs.slice(start_index,ordered_logs.length-1)
  end

end


