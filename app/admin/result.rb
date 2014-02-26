ActiveAdmin.register Result do
  index do
    column :year, sortable: :year do |result|
      div class: "year" do
        result.year
      end
    end
    column "Participant", sortable: :participant_id do |result|
      Participant.find(result.participant_id).name
    end
    column :round, sortable: :round do |result|
      div class: "round" do
        result.round
      end
    end
    column "Game Payout", sortable: :bracket_position_id do |result|
      div class: "payout" do
        number_to_currency Payout.find_by(round: result.round, year: result.year).game_payout
      end
    end
    column "Date Created", :created_at
    column "Date Updated", :updated_at
    default_actions
  end
end
