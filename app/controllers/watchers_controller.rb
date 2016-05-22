class WatchersController < ApplicationController
  def index
    @watchers = Watcher.all
  end
end
