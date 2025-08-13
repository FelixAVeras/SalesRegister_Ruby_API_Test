class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  before_action :set_paper_trail_whodunnit

  private

  def user_for_paper_trail
    current_admin_user&.id
  end
end
