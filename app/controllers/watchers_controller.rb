class WatchersController < ApplicationController
  before_action :require_login
  before_action :set_watcher,     only: [:show, :destroy]
  before_action :check_ownership, only: [:show, :destroy]

  # GET /watchers
  def index
    @watcher = Watcher.new
    @watchers = current_user.watchers
  end

  # GET /watchers/1
  def show
    @added_friends   = @watcher.friends.select { |friend| friend.id.in? @watcher.added_friends_ids }
    @deleted_friends = @watcher.friends.select { |friend| friend.id.in? @watcher.deleted_friends_ids }
    @friends         = @watcher.friends - @added_friends - @deleted_friends
  end

  # POST /watchers
  def create
    if watcher_params[:vk_url].present?
      vk_id = Watcher.parse_vk_id(watcher_params[:vk_url])
      @watcher = Watcher.new(domain: vk_id, user: current_user)
      WatchersFriendsService.new(@watcher).fetch_watcher
      FetchFriendsJob.perform_later(@watcher)
      redirect_to watchers_url, notice: 'Successfully created watcher'
    else
      redirect_to watchers_url, alert: 'Unable to create watcher!'
    end
  end

  # DELETE /watchers/:id
  def destroy
    @watcher.destroy
    redirect_to watchers_url, notice: 'Watcher was successfully destroyed'
  end

  private

  def set_watcher
    @watcher = Watcher.includes(:friends).find(params[:id])
  end

  def check_ownership
    return if @watcher.user == current_user
    redirect_to watchers_url, alert: 'You can access only your own watchers!'
  end

  def watcher_params
    params.require(:watcher).permit(:vk_url)
  end
end
