class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.where('title like ?', "%#{params[:city]}%").paginate(:page => params[:page], :per_page => 30)
  end
end
