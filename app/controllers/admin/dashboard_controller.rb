class Admin::DashboardController < AdminPanelController
  layout 'admin'
  def index
    @users = User.count
  end
end
