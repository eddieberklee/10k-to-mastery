# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Log.delete_all
Activity.delete_all

Activity.create(name: 'codeacademy', whichtype: 'checkmark')
Activity.create(name: 'running', whichtype: 'count')

@activities = Activity.all

number_of_logs = 6
start_date = Time.now

@activities.each do |activity|
  (1..number_of_logs).each do |i|
    log = activity.logs.new(fordate: start_date - i*60*60*24)

    if activity.whichtype == 'checkmark'
      log_value = true ? i <= number_of_logs / 2 : log_value = false
      log.update_attributes({
        checkmark: log_value,
        whichtype: 'checkmark',
      })
    elsif activity.whichtype == 'count'
      log_value = i
      log.update_attributes({
        count: log_value,
        whichtype: 'count',
      })
    end

  end
end





