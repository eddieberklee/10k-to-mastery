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
    ordered_logs = self.ordered_logs
    
    most_recent = self.logs[-2]
    unless most_recent.nil?
      # technically fordate is already a date object though
      if most_recent.fordate.to_date == Time.now.to_date
        most_recent
      end
    end
  end

  def ordered_logs
    ordered_logs = self.logs.order('fordate')
  end

  def past_logs
    limit = 4
    ordered_logs = self.ordered_logs
    if ordered_logs.empty? or ordered_logs.nil?
      []
    else
      ordered_logs = self.ordered_logs.reverse
      if ordered_logs[0].fordate.to_date == Time.now.to_date
        ordered_logs.slice(1, 4).reverse
      else
        ordered_logs.slice(0, 4).reverse
      end

    end
  end

end


