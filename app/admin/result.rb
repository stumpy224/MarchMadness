ActiveAdmin.register Result do
  permit_params :participant_id, :round, :year, :game_id

  form do |f|
    f.inputs do
      f.input :participant_id, as: :select, collection: Participant.all.order(:name)
      f.input :round
      f.input :year, as: :select, collection: Year.all.order(year: :desc).map{ |y| ["#{y.year}", y.year] }
      f.input :game_id
    end

    f.actions
  end

  action_item only: :show do
    link_to 'New Result', new_admin_result_path, method: :get
  end
  
  index do
    column :year, sortable: :year do |result|
      div class: 'year' do
        result.year
      end
    end
    column 'Participant', sortable: :participant_id do |result|
      Participant.find(result.participant_id).name
    end
    column :round, sortable: :round do |result|
      div class: 'round' do
        result.round
      end
    end
    column 'Game Payout' do |result|
      div class: 'payout' do
        number_to_currency Payout.find_by(round: result.round, year: result.year).game_payout
      end
    end
    column 'Game Id', sortable: :game_id do |result|
      div class: 'game' do
        result.game_id
      end
    end
    column 'Date Created', :created_at
    column 'Date Updated', :updated_at
    default_actions
  end
end
