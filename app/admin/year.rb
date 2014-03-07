ActiveAdmin.register Year do
  permit_params :year, :source_url

  form do |f|
    f.inputs :year, :source_url
    f.actions
  end
  
  index do
    column :year, sortable: :year do |y|
      div class: 'year' do
        y.year
      end
    end
    column :source_url
    column :results_last_updated_at, sortable: :results_last_updated_at
    column :bracket_last_updated_at, sortable: :bracket_last_updated_at
    default_actions
  end
end
