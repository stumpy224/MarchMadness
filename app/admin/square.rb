ActiveAdmin.register Square do
  permit_params :winner_digit, :loser_digit, :year, :participant_id
end
