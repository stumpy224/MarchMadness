ActiveAdmin.register Region do
  permit_params :name, :year, :style, :quadrant_id

  config.sort_order = "year_asc, quadrant_id_asc"

  form do |f|
    f.inputs do
      f.input :name
      f.input :year, :value => 'Time.now.year'
      f.input :style
      f.input :quadrant_id
    end

    f.actions
  end
end
