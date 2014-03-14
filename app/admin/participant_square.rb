ActiveAdmin.register ParticipantSquare do
  permit_params :participant_id, :square_id, :year
  
  config.sort_order = 'year_desc'

  form do |f|
    f.inputs do
      f.input :participant_id, as: :select, collection: 
        Participant.select(:id, :name).order(:name)
      f.input :year, label: 'Year', as: :select,
        collection: Year.all.order(year: :desc).map{|y| ["#{y.year}", y.year]}
      f.input :square_id, label: 'Square', as: :select,
        collection: Square.all.map{|s| ["W:#{s.winner_digit} L:#{s.loser_digit}", s.id]}
    end

    f.actions
  end

  action_item only: :show do
    link_to 'New Participant Square', new_admin_participant_square_path, method: :get
  end

  index do
    column :participant_id, sortable: :participant_id do |s|
      Participant.find(s.participant_id).preferred_name
    end
    column :square_id, sortable: :square_id do |s|
      @square = Square.find(s.square_id)
      "W:#{@square.winner_digit} L:#{@square.loser_digit}"
    end
    column :year, sortable: :year
    column :created_at, sortable: :created_at
    column :updated_at, sortable: :updated_at
    default_actions
  end
end
