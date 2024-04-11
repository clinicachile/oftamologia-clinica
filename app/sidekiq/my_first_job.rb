class MyFirstJob
  include Sidekiq::Job

  def perform(name)
    puts "hola #{name} te saludos desde sidekiq"
  end
end
