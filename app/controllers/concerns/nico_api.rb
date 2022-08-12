module NicoApi
  extend ActiveSupport::Concern

  def fetch_nico(query:, targets: 'title,tags', sort: '-viewCounter', limit: 10, filters: {})
    uri = URI 'https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search'
    uri.query = build_nico_query(query:, targets:, sort:, limit:, filters:)
    response = HTTP.get uri.to_s
    raise StandardError, "Nico video api error: #{response.body}" unless response.status.success?

    JSON.parse(response.body.to_s, symbolize_names: true)[:data].presence || []
  end

  private

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
end
