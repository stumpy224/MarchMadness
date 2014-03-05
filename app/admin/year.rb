ActiveAdmin.register Year do
  permit_params :year, :source_url

  form do |f|
    f.inputs :year, :source_url
    f.actions
  end
  
end
