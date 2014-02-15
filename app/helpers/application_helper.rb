module ApplicationHelper
	def full_title(page_title)
		base_title = "March Madness"

		page_title.empty? ? base_title : base_title + " | " + page_title
	end
end
