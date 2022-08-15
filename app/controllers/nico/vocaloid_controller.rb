class Nico::VocaloidController < ApplicationController
  include NicoApi
  before_action :logged_in

  def index
    begin
      @date = params[:date].presence ? Date.parse(params[:date]) : Date.today
    rescue Date::Error
      @date = Date.today
    end
    @videos = fetch @date
  end

  private

  def fetch(date)
    filters = {
      startTime: {
        gte: "#{date.iso8601}T00:00:00+09:00",
        lte: "#{date.iso8601}T23:59:59+09:00"
      },
      viewCounter: {
        gte: 3000
      }
    }
    fetch_nico(query: 'VOCALOID オリジナル', limit: 30, filters:)
  end
end
