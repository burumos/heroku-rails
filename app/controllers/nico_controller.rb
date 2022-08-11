class NicoController < ApplicationController
  before_action :logged_in

  def index; end

  def search
    @query = params[:query]
    @limit = params[:limit].presence || 10
    @minimum_views = params[:minimum_views].presence || 1000
    filters = { viewCounter: { gt: @minimum_views } }
    @videos = @query.blank? ? [] : fetch_nico(query: @query, limit: @limit, filters:, sort: '-startTime')
    @conditions = NicoCondition.where(user_id: @user.id)
  end

  def create_condition
    condition = NicoCondition.new condition_params.merge({ user_id: @user.id })
    rails StandardError, 'Invalid data.' unless condition.valid?
    condition.save
    render json: { result: 'success', data: condition }
  end

  def destroy_condition
    condition = NicoCondition.find(params[:id])
    raise StandardError, 'You don\'t have permission.' if condition.user_id != @user.id

    condition.destroy
    render json: { result: 'success', condition: }
  end

  private

  def condition_params
    params.permit(:query, :limit, :minimum_views)
  end

  def fetch_nico(query:, targets: 'title,description,tags', sort: '-viewCounter', limit: 10, filters: {})
    uri = URI 'https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search'
    uri.query = build_nico_query(query:, targets:, sort:, limit:, filters:)
    response = HTTP.get uri.to_s
    JSON.parse(response.body.to_s, symbolize_names: true)[:data]
  end

  def build_nico_query(query:, targets:, sort:, limit:, filters:)
    {
      q: query,
      filters:,
      targets:,
      _sort: sort,
      _context: 'rails-nk',
      fields: 'contentId,title,tags,viewCounter,likeCounter,lengthSeconds,thumbnailUrl,commentCounter,startTime',
      _limit: limit
    }.to_param
  end

  def test_data
    [
      {
        startTime: '2017-09-10T19:07:24+09:00',
        tags: '7_days_to_die VOICEROID実況プレイ クソリプ４銃士 ゲーム マッスル広告感謝 例のアレ 偽乳特戦隊 東北きりたん実況プレイ 結月ゆかりファンのマッスルサイド 結月ゆかり実況プレイ',
        lengthSeconds: 796,
        viewCounter: 9991,
        contentId: 'sm31901870',
        title: '【7DTD】きりたんとイスになったゆかりんの９脚目α16.3【VOICEROID実況】',
        commentCounter: 261,
        likeCounter: 0,
        thumbnailUrl: 'https://nicovideo.cdn.nimg.jp/thumbnails/31901870/31901870'
      },
      {
        startTime: '2015-06-11T19:33:00+09:00',
        tags: '7days_to_die 7DTD 7_days_to_die VOICEROID実況プレイ ゲーム 弦巻マキ実況プレイ 琴葉茜・葵実況プレイ 結月ゆかり 葵ちゃん＠がんばらない 葵ちゃん＠運が無い 重い葵ちゃん',
        lengthSeconds: 878,
        viewCounter: 9986,
        contentId: 'sm26464385',
        title: '【7Days to die】葵ちゃん＠がんばらない【Part3】',
        commentCounter: 202,
        likeCounter: 1,
        thumbnailUrl: 'https://nicovideo.cdn.nimg.jp/thumbnails/26464385/26464385'
      }
    ]
  end
end
