#! /usr/bin/env ruby
require 'json'

event = JSON.parse(STDIN.read, symbolize_names: true)

tags = { tags: { service: event[:check][:name].split('_metric')[0],
                 status: event[:check][:status].to_i } }

event[:check].merge!(tags)

puts JSON.dump(event)
