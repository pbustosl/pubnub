# monitoring_agent.rb

require 'istats' # gem install iStats # gem for your mac stats (cpu, fan, etc)
require 'logger'
require 'pubnub'

abort ("usage: #{File.basename $0} subscribe_key publish_key <cpu|fan>") unless ARGV.size == 3

subscribe_key = ARGV[0]
publish_key = ARGV[1]
service = ARGV[2]

logger = Logger.new(STDOUT)

pubnub = Pubnub.new(
    :subscribe_key    => subscribe_key,
    :publish_key      => publish_key,
    :error_callback   => lambda { |msg|
      logger.error "SOMETHING TERRIBLE HAPPENED HERE: #{msg.inspect}"
    },
    :connect_callback => lambda { |msg|
      logger.info "CONNECTED: #{msg.inspect}"
    }
)

@pub_callback = lambda { |envelope| logger.info "pub: #{envelope.msg}" }

loop do
  if service == 'cpu'
    msg = {
      monitor: 'CPU',
      metric: 'temp',
      value: IStats::Cpu.get_cpu_temp
    }
  else
    msg = {
      monitor: 'Fan',
      metric: 'speed',
      value: IStats::Fan.get_fan_speed(0)
    }
  end
  pubnub.publish(
      :channel  => :system_metrics,
      :message  => msg,
      :callback => @pub_callback
  )
  sleep 1
end
