class Admin::DashboardController < AdminPanelController
  layout 'admin'
  def index
    @users = Pacient.count
    @moneys = Appointment.where('start_time BETWEEN ? AND ?', Date.today.at_beginning_of_month,
                                Date.today.at_end_of_month).sum(:price)
    @appointments = Appointment.where(start_time: Date.today.all_day).count
  end
end
