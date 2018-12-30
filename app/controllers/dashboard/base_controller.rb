class Dashboard::BaseController < ApplicationController
  before_action :require_merchant

  private

  def require_merchant
    render_404 unless current_merchant?
  end
end
