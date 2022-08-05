class NicoController < ApplicationController
  before_action :logged_in

  def index; end

  def search
    @response = HTTP.get('https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search?q=UTAU&targets=title,description,tags&_sort=-viewCounter&_context=rails-nk&fields=contentId,title,description,tags')
    @response_body = JSON.parse @response.body.to_s
  end
end
