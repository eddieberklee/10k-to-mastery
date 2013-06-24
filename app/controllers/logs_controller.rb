class LogsController < ApplicationController
  def index
  end

  # POST /logs
  # POST /logs.json
  def create
    @activity = Activity.find(params[:log][:activity_id])
    @log = @activity.logs.new(params[:log])

    respond_to do |format|
      if @log.save
        format.html { redirect_to @activity, :notice => 'Activity was successfully created.' }
        format.json { render :json => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end

  end
end
