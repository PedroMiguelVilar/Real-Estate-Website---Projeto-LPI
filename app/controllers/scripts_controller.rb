class ScriptsController < ApplicationController

    def index
      render :dashboard
    end

    def run_script
      # Execute your Python script using the system method
      system("python #{Rails.root}/python/web_scraper_houses.py")
      system("python #{Rails.root}/python/webscraper_single_house.py")
      system("python #{Rails.root}/python/body_sapo.py")
      system("python #{Rails.root}/python/update_db.py")
      
  
      # Redirect to the index page to show the user that the script was executed
      redirect_to scripts_path
    end
  end
  