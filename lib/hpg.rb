require 'hpg/version'
require 'uri'
require 'logging'

module HPG
  class HPGInternal
    attr_accessor :logger
    attr_accessor :host, :database, :user, :port, :password

    def initialize
      # set up logger
      if defined?(Rails.logger) && Rails.logger
        @logger = Rails.logger
      else
        @logger = Logging.logger(STDOUT)
        @logger.level = :info
      end

      # parse env var
      url = find_url
      if url
        parse_url(url)
      end
    end

    def find_url
      candidates = ENV.keys.select do |k|
        k =~ /^HEROKU_POSTGRESQL_[A-Z_]+?_URL$/
      end

      key = candidates[0]

      case candidates.length
      when 0
        @logger.fatal 'Could not find the Heroku Postgres URL in ENV'
        @logger.info 'Fix: run `heroku addons:add heroku-postgresql`'
        nil
      when 1
        ENV[key]
      else
        key = candidates.first
        @logger.warn "Found multiple Heroku Postgres URLs; using #{key}"
        @logger.info 'Fix: go to Heroku Dashboard -> Your app -> Settings -> Reveal Config Vars, and delete the extra database config variables'
        ENV[key]
      end
    end

    def parse_url(url)
      begin
        uri = URI.parse(url)
      rescue URI::InvalidURIError
        @logger.fatal 'Heroku Postgres URL is invalid (parse error)'
        @logger.info 'Fix: go to Heroku Dashboard -> Your app -> Settings -> Reveal Config Vars, and make sure the URL is a valid URI'
        return
      end

      if uri.scheme == 'postgres'
        @host = uri.host
        @database = uri.path[1..-1]
        @user = uri.user
        @port = uri.port
        @password = uri.password
        @logger.info 'Successfully grabbed the Heroku Postgres configuration'
      else
        @logger.fatal 'Heroku Postgres URL is invalid (wrong URI scheme)'
        @logger.info 'Fix: go to Heroku Dashboard -> Your app -> Settings -> Reveal Config Vars, and make sure the URL starts with postgres://'
      end
    end
  end

  @@hpg = HPGInternal.new

  def self.host
    @@hpg.host
  end

  def self.database
    @@hpg.database
  end

  def self.user
    @@hpg.user
  end

  def self.port
    @@hpg.port
  end

  def self.password
    @@hpg.password
  end
end
