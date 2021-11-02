module ApplicationHelper
  include Pagy::Frontend
  
  # Returns a full title on a per page basis
  def full_title(page_title= '')
    # base_title = t('app.name')
    base_title = "Forecastly Weather Application"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Returns 'active' if the current path is the active class, otherwise empty
  def active?(test_path)
    return 'active' if current_page? test_path
  end
end
