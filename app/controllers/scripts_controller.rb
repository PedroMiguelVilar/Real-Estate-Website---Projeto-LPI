class ScriptsController < ApplicationController
  def index
    render :dashboard
  end

  def run_script
    # Enqueue the script to be executed in the background immediately
    ScriptRunner.new.delay(run_at: 0.seconds.from_now).perform
    # Redirect to the index page to show the user that the script was enqueued
    system('rails jobs:work')
    redirect_to scripts_path
  end

  # Define a separate class to execute the script in the background
  class ScriptRunner < Struct.new(:args)
    def perform
      # Execute your Python script using the system method

      puts "#5 map_distritcs"

      # Create an instance of ActionController::Base and simulate a request to the map_districts action
      house_controller = HouseController.new
      request = ActionDispatch::Request.new('HTTP_HOST' => 'localhost:3000', 'REMOTE_ADDR' => '127.0.0.1')
      house_controller.instance_variable_set(:@request, request)
      house_controller.instance_variable_set(:@response, ActionDispatch::Response.new)
      house_controller.params = {}
      house_controller.process(:map_districts)

      puts "DONE"
    end
  end
end
