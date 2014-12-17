require 'thor'
require 'amarok-data-collector/database'
require 'amarok-data-collector/config'

module AmarokDataCollector
  class Tasks < Thor

    desc 'install', 'Install config file and schedule'
    def install
      @amarok_db       = AmarokDataCollector::Database.new
      @amarok_stats_db = AmarokDataCollector::Database.new

      ask_amarok_credentials
      ask_amarok_stats_credentials
      AmarokDataCollector::Config.write_config @amarok_db, @amarok_stats_db

      say "Config saved in file #{AmarokDataCollector::Config.config_file}"
    end

    private

    def ask_amarok_credentials
      ask_credentials @amarok_db, :amarok
      if @amarok_db.have_access_to_db?
        say "Successfully connected to DB #{@amarok_db.database}"
      elsif @amarok_db.credentials_valid?
        say "Credentials are valid, but cannot access to #{@amarok_db.database}"
      else
        ask_amarok_credentials if yes?('It seems credentials are invalid. Would you like to set valid credentials?')
      end
    end

    def ask_amarok_stats_credentials
      ask_credentials @amarok_stats_db, :amarok_stats
      if @amarok_stats_db.have_access_to_db?
        if @amarok_stats_db.have_tables?
          question = "Successfully connected to DB #{@amarok_stats_db.database}, but it has tables. Do you really want to use this table?"
          ask_amarok_stats_credentials if no?(question)
        else
          say "Successfully connected to DB #{@amarok_stats_db.database}, and it is empty"
        end
      elsif @amarok_stats_db.credentials_valid?
        say "Credentials are valid, but cannot access to #{@amarok_stats_db.database}"
      else
        ask_amarok_stats_credentials if yes?('It seems credentials are invalid or user is not created. Would you like to set valid credentials?')
      end
    end

    def ask_credentials(db, default_name)
      db.database  = ask "#{default_name} DB:",         default: default_name
      db.username = ask "#{default_name} DB user:",     default: default_name
      db.password = ask "#{default_name} DB password:", echo: false
      puts
    end

    def apply_migrations
      # todo
    end



    def print_instructions
      # todo
    end

  end
end
