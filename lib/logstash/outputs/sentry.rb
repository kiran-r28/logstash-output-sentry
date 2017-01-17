# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "raven/base"
require "yaml"

# An sentry output that does nothing.
class LogStash::Outputs::Sentry < LogStash::Outputs::Base
  config_name "sentry"

  config :dsn_key_file, :validate => :string,  :required => true
  config :project_id,   :validate => :string,  :required => true
  config :message,      :validate => :string,  :required => false
  config :level,        :validate => :string,  :required => false, :default => 'error'
  config :host,         :validate => :string,  :required => false, :default => 'sentry.io'
  config :enable_ssl,   :validate => :boolean, :required => false, :default => true

  public
  def register
    if FileTest.exist?(@dsn_key_file)
      dsn_keys = YAML.load_file(@dsn_key_file)
    else
      raise LogStash::ConfigurationError,	"dsn_key_file '#{@dsn_key_file}' not found"
    end

    public_key = dsn_keys['public_key']
    secret_key = dsn_keys['secret_key']

    protocol = @enable_ssl? 'https' : 'http'

    dsn = "#{protocol}://#{dsn_keys['public_key']}:#{dsn_keys['secret_key']}@#{@host}/#{@project_id}"

    Raven.configure do |config|
      config.dsn = dsn
      config.open_timeout = 20
    end

    @logger.info("Configured sentry with", :project_id => @project_id)
  end

  public
  def receive(event)
    Raven.capture_message(@message, :extra => event)
    return "Event received"
  end
end
