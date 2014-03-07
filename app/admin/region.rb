ActiveAdmin.register Region do
  permit_params :name, :year, :style, :quadrant_id

  config.sort_order = 'year_desc, quadrant_id_asc'

  form do |f|
    f.inputs do
      f.input :name
      f.input :year, :value => 'Time.now.year'
      f.input :style
      f.input :quadrant_id
    end

    f.actions
  end

  index do
    column :year, sortable: :year do |r|
      div class: 'year' do
        r.year
      end
    end
    column :name, sortable: :name
    column :quadrant_id, sortable: :quadrant_id do |r|
      div class: 'quadrantId' do
        r.quadrant_id
      end
    end
    column :style, sortable: :style
    column :created_at, sortable: :created_at
    column :updated_at, sortable: :updated_at
    default_actions
  end

  action_item only: :show do
    link_to 'New Region', new_admin_region_path, method: :get
  end
end
