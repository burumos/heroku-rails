module Nico::GameHelper
  def last_updated
    return unless @updated_at.respond_to?('strftime') && @updated_at.respond_to?('to_datetime')

    diff = DateTime.now - @updated_at.to_datetime
    return '最近' if diff < 0.1

    "#{diff.to_i}日と#{((diff - diff.to_i) * 24).to_i}時間前"
  end
end
