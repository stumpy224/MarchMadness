ActiveAdmin.register Participant do
  permit_params :name, squares_attributes: [:id, :winner_digit, :loser_digit, :year, :_destroy]

  form do |f|
    f.inputs do
      f.input :name
    end

    f.inputs "Squares" do
      f.has_many :squares do |square|
        square.input :winner_digit
        square.input :loser_digit
        square.input :year, :as => :hidden, :value => Time.now.year
      end
    end

    f.actions
  end
end
