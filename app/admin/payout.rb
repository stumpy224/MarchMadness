ActiveAdmin.register Payout do
  permit_params :game_payout, :round, :year

  config.sort_order = 'year_asc, game_payout_asc'

  form do |f|
    f.inputs do
      f.input :game_payout
      f.input :round
      f.input :year, as: :select,
        collection: Year.all.order(year: :desc).map{ |y| ["#{y.year}", y.year] }
    end

    f.actions
  end

  index do
    column :year
    column :round, sortable: :round do |payout|
      div class: 'round' do
        payout.round
      end
    end
    column :game_payout, sortable: :game_payout do |payout|
      div class: 'payout' do
        number_to_currency payout.game_payout
      end
    end
    column 'Date Created', :created_at
    column 'Date Updated', :updated_at
    default_actions
  end

  action_item only: :show do
    link_to 'New Payout', new_admin_payout_path, method: :get
  end
end
