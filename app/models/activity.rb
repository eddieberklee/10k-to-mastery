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
    month <= 9 ? month = "0#{month}" : 'nothing to worry about'
    day = time.day
    day <= 9 ? day = "0#{day}" : 'nothing to worry about'

    ordered_logs = self.ordered_logs
    logger.debug ordered_logs.inspect
    # self.logs.where("fordate = #{year}-#{month}-#{day}").first
    
    most_recent = self.logs[-2]
    unless most_recent.nil?
      if most_recent.fordate == Time.now.to_date
        most_recent
      end
    end
  end

  def ordered_logs
    ordered_logs = self.logs.order('fordate')
  end

  def past_logs
    limit = 4
    unless ordered_logs.empty? or ordered_logs.nil?
      ordered_logs = self.ordered_logs.reverse
      ordered_logs.slice(1, 4).reverse
    end
    []
  end

end


