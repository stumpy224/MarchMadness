module ApplicationHelper
  def full_title(page_title)
    base_title = 'The Grid Pool'
    page_title.empty? ? base_title : base_title + " | " + page_title
  end

  def get_latest_year
    Year.order(:year).last.year
  end
end
