# frozen_string_literal: true

module Admin
  module Appointments
    class AppointmentCreateService
      def initialize(params)
        @params = params
      end

      def call
        appointment_create
      rescue StandardError => e
        false
      end

      def appointment_create
        @appointment = Appointment.new(@params)
        @appointment.user_id = current_user

        if @appointment.save
          true
        else
          false
        end
      end
    end
  end
end
