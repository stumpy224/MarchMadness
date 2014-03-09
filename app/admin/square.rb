ActiveAdmin.register Square do
  permit_params :winner_digit, :loser_digit

  config.sort_order = 'id_asc'  
end
