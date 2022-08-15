class Nico::GameController < ApplicationController
  include NicoApi
  before_action :logged_in

  def index
    nico_game = NicoGame.find_by user_id: @user.id
    if nico_game.nil?
      @videos = []
    else
      @videos = JSON.parse(nico_game.videos, { symbolize_names: true })
      @updated_at = nico_game.updated_at
    end
  end

  def create
    videos = fetch_videos
    save_nico_game(videos)

    redirect_to nico_game_path, notice: '更新しました!!'
  rescue StandardError => e
    redirect_to nico_game_path, notice: "更新に失敗!!: #{e.message}"
  end

  private

  def fetch_videos
    videos = []
    videos.concat(fetch_video(query: 'mtg -mtga -mtgアリーナ', limit: 5, smallest_views: 300))
    videos.concat(fetch_video(query: 'sims -MMD -MikuMikuDance', limit: 5, smallest_views: 100))
    videos.concat(fetch_video(query: 'tropico', limit: 3, smallest_views: 300))
    videos.concat(fetch_video(query: 'cities:skylines', limit: 5, smallest_views: 500))
    videos.concat(fetch_video(query: 'ets2 -MMD -切り抜き', limit: 5, smallest_views: 100))
    videos.sort_by! { |video| video[:startTime] }.reverse!
  end

  def fetch_video(query:, limit:, smallest_views:)
    fetch_nico(query:, limit:, sort: '-startTime', filters:
    {
      viewCounter: { gte: smallest_views },
      startTime: { gte: "#{Date.today.months_ago(1).iso8601}T00:00:00+09:00" }
    })
  end

  def save_nico_game(videos)
    nico_game = NicoGame.find_by user_id: @user.id
    if nico_game.nil?
      nico_game = NicoGame.new
      nico_game.user_id = @user.id
    end
    nico_game.videos = videos.to_json
    nico_game.save
  end
end
