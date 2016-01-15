# monitor.rb

require 'logger'
require 'pubnub'

abort ("usage: #{File.basename $0} subscribe_key") unless ARGV.size == 1

subscribe_key = ARGV[0]

logger = Logger.new(STDOUT)

pubnub = Pubnub.new(
    :subscribe_key    => subscribe_key,
    :error_callback   => lambda { |msg|
      logger.error "SOMETHING TERRIBLE HAPPENED HERE: #{msg.inspect}"
    },
    :connect_callback => lambda { |msg|
      logger.error "CONNECTED: #{msg.inspect}"
    }
)

@sub_callback = lambda { |envelope| logger.info "sub: #{envelope.msg}" }
pubnub.subscribe(
    :channel  => :system_metrics,
    :callback => @sub_callback
)

Thread.list.each do |t|
  t.join if t != Thread.current
end
