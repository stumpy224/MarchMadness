ActiveAdmin.register Payout do
  config.sort_order = "year_asc, game_payout_asc"

  index do
    column :year
    column :round
    column :game_payout, sortable: :game_payout do |payout|
      div class: "payout" do
        number_to_currency payout.game_payout
      end
    end
    column "Date Created", :created_at
    column "Date Updated", :updated_at
    default_actions
  end
end
