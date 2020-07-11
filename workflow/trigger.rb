#!/usr/bin/env ruby

require 'json'
require 'net/http'


headers = {
  'Accept' => 'application/vnd.github.everest-preview+json',
  'Content-Type' => 'application/json',
  'Authorization' => "Bearer #{ENV['TOKEN']}"
}


puts ENV.to_h
url = "https://api.github.com/repos/Boberkraft/tweetster-rails-api/actions/runs/#{ENV['GITHUB_RUN_ID']}/jobs"
puts url
url = URI.parse(url)
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
x = http.get(url.path, headers.merge('Accept' => 'application/vnd.github.antiope-preview+json'))
puts "ok!ok!"
puts x
puts x.inspect
puts x.body
puts "ok!ok!"

ENV['REPOSITORIES'].split.each do |app_name|
  params = {
    event_type: "on-demand-test",
    client_payload: {
      branch_name: '....',
      repository_name: app_name,
      comment_repository_name: ENV['REPOSITORY_NAME'],
      comment_id: ENV['COMMENT_ID']
    }
  }

  url = URI.parse('https://api.github.com/repos/Boberkraft/tweetster-rails-api/dispatches')
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.post(url.path, params.to_json, headers)




  puts "#{app_name} sheluded"
end

