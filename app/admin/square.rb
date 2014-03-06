ActiveAdmin.register Square do
  permit_params :winner_digit, :loser_digit, :year, :participant_id

  index do
    column "Participant", sortable: :participant_id do |s|
      Participant.find(s.participant_id).name
    end
    column :winner_digit, sortable: :winner_digit
    column :loser_digit, sortable: :loser_digit
    column :year, sortable: :year
    column :created_at, sortable: :created_at
    column :updated_at, sortable: :updated_at
    default_actions
  end
end
