class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    city = params[:city] ? params[:city].strip : ''
    @jobs = Job.order('published_at desc').paginate(:page => params[:page], :per_page => 30)
    @jobs = @jobs.where('title like ?', "%#{city}%") if city.present?
  end

  def show
    @job = Job.find(params[:id])
  end

end
