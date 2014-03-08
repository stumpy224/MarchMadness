ActiveAdmin.register Participant do
  permit_params :name, squares_attributes: [:id, :winner_digit, :loser_digit, :year, :_destroy]

  form do |f|
    f.inputs do
      f.input :name
    end

    f.inputs 'Squares' do
      f.has_many :squares do |s|
        if (Time.now.year.to_s == '2014')
          s.input :winner_digit
          s.input :loser_digit
          s.input :year, :value => '2013'#, :as => :hidden
        else
          s.input :winner_digit, input_html: { disabled: true }
          s.input :loser_digit, input_html: { disabled: true }
          s.input :year, input_html: { disabled: true }
        end
      end
    end

    f.actions
  end

  action_item only: :show do
    link_to 'New Participant', new_admin_participant_path, method: :get
  end
end
