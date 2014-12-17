require 'mysql2'

module AmarokDataCollector
  class Database
    attr_accessor :database, :username, :password

    def connect_to_db
      @connect_to_db ||= Mysql2::Client.new host: :localhost, database: database, username: username, password: password
    rescue Mysql2::Error
      nil
    end

    def connect_to_dbms
      @connect_to_dbms ||= Mysql2::Client.new host: :localhost, username: username, password: password
    rescue Mysql2::Error
      nil
    end

    def credentials_valid?
      !!connect_to_dbms
    end

    def have_access_to_db?
      !!connect_to_db
    end

    def have_tables?
      raise StandardError unless have_access_to_db? # todo

      connect_to_db.query('SHOW TABLES').count > 0
    end

    def host
      :localhost
    end

    def to_config
      [:host, :database, :username, :password].reduce({}) { |memo, p| memo[p] = self.send(p); memo }
    end

  end
end
