#!/usr/bin/env ruby

require 'json'
require 'net/http'

headers = {
  'Accept' => 'application/vnd.github.antiope-preview+json',
  'Content-Type' => 'application/json',
  'Authorization' => "Bearer #{ENV['TOKEN']}"
}


url = "https://api.github.com/repos/Boberkraft/tweetster-rails-api/actions/runs/#{ENV['GITHUB_RUN_ID']}/jobs"
url = URI.parse(url)
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
x = http.get(url.path, headers)

puts x
puts x.inspect
puts x.body

parsed = JSON.parse(x.body)

if parsed['total_count'] != 1
  raise 'cos mi tutaj nie gra, nie wiem jak dostac linka'
end

url = parsed['jobs'][0]['html_url']

puts "mam url!"
puts url

system("echo ::set-output name=run-url::#{url}")