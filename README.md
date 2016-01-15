# pubnub Hello World

run a monitoring agent for your Mac's CPU on terminal2:
```
ruby monitoring_agent.rb <subscription_key> <publish_key> cpu
```

run a monitoring agent for your Mac's fan on terminal3:
```
ruby monitoring_agent.rb <subscription_key> <publish_key> fan
```

run the system monitor on terminal1:
```
ruby monitor.rb <subscription_key>
```
verify the monitor is receiving from the agents:
```
I, [2016-01-14T16:58:12.211976 #51421]  INFO -- : sub: {"monitor"=>"CPU", "metric"=>"temp", "value"=>38.125}
I, [2016-01-14T16:58:12.804303 #51421]  INFO -- : sub: {"monitor"=>"Fan", "metric"=>"speed", "value"=>2165.0}
I, [2016-01-14T16:58:12.987054 #51421]  INFO -- : sub: {"monitor"=>"CPU", "metric"=>"temp", "value"=>38.125}
I, [2016-01-14T16:58:13.815776 #51421]  INFO -- : sub: {"monitor"=>"Fan", "metric"=>"speed", "value"=>2161.0}
I, [2016-01-14T16:58:13.999103 #51421]  INFO -- : sub: {"monitor"=>"CPU", "metric"=>"temp", "value"=>38.125}
I, [2016-01-14T16:58:14.850480 #51421]  INFO -- : sub: {"monitor"=>"Fan", "metric"=>"speed", "value"=>2158.0}
```