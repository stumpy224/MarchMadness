ActiveAdmin.register Participant do
  permit_params :name, :display_name, participant_squares_attributes: [:id, :square_id, :year, :_destroy]

  config.sort_order = 'name_asc'

  form do |f|
    f.inputs do
      f.input :name
      f.input :display_name
    end

    f.inputs 'Squares' do
      f.has_many :participant_squares do |s|
        s.input :year, as: :select,
          collection: Year.all.order(year: :desc).map{ |y| ["#{y.year}", y.year] }
        s.input :square_id, as: :select,
          collection: Square.all.map{ |s| ["W:#{s.winner_digit} L:#{s.loser_digit}", s.id] }

        # s.input :square_id, as: :select,
        #   collection: Square.where('id IN (?) OR id NOT IN (?)', 
        #     ParticipantSquare.select(:square_id).where(participant_id: params[:id], year: Time.now.year), 
        #     ParticipantSquare.select(:square_id)).map{ |s| ["W:#{s.winner_digit} L:#{s.loser_digit}", s.id] }
      end
    end

    f.actions
  end

  action_item only: :show do
    link_to 'New Participant', new_admin_participant_path, method: :get
  end
end
