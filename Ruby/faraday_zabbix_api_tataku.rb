#!/usr/bin/env ruby
 
require "faraday"
require "json"
require "pp"
 
conn = Faraday::Connection.new(:url => 'http://example.com/')
 
json_body = {
  "jsonrpc" => "2.0",
  "auth"    => "********************************",
  "method"  => "item.get", 
  "id"      => "1",
  "params"  => {
          "hostids" => "10000"
  },
}.to_json
 
responce = conn.post '/zabbix/api_jsonrpc.php' do |request|
  request.params['limit'] = 100
  request.headers['Content-Type'] = 'application/json-rpc'
  request.body = json_body
end
 
pp responce.body
