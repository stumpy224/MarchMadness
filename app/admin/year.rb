ActiveAdmin.register Year do
  permit_params :year, :source_url, :winner_digits, :loser_digits

  form do |f|
    f.inputs :year, :source_url, :winner_digits, :loser_digits
    f.actions
  end
  
  index do
    column :year, sortable: :year do |y|
      div class: 'year' do
        y.year
      end
    end
    column :source_url
    column :winner_digits
    column :loser_digits
    default_actions
  end
end
