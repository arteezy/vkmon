class WatchersController < ApplicationController
  before_action :set_watcher, only: :destroy

  # GET /watchers
  def index
    @watcher = Watcher.new
    @watchers = Watcher.all
  end

  # POST /watchers
  def create
    @watcher = Watcher.new(watcher_params)
    @watcher.user = current_user
    if @watcher.save
      redirect_to watchers_url, notice: 'Successfully created watcher'
    else
      redirect_to watchers_url, alert: 'Unable to create watcher'
    end
  end

  # DELETE /watchers/:id
  def destroy
    @watcher.destroy
    redirect_to watchers_url, notice: 'Watcher was successfully destroyed'
  end

  private

  def set_watcher
    @watcher = Watcher.find(params[:id])
  end

  def watcher_params
    params.require(:watcher).permit(:vk_id, :name, :photo)
  end
end
