json.array!(@payouts) do |payout|
  json.extract! payout, :id, :game_payout, :round, :year
  json.url payout_url(payout, format: :json)
end
