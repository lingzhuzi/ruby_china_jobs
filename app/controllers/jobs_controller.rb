class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.where('title like ?', "%#{params[:city]}%").order('published_at desc').paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @job = Job.find(params[:id])
  end
end
