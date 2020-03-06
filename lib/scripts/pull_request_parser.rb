#!/usr/bin/env ruby

require 'json'

# https://stackoverflow.com/questions/2660571/exporting-an-environment-variable-in-ruby
#
def pr_body_settings
  body = ENV['PR_BODY'] || ' { "other_repo_branch_name": "kabandasdosy" } '

  raise 'Nie ma ustawień bota?' if body.index('{').nil? || body.index('}').nil?

  hash_str = body[body.index('{')..-body.reverse.index('}') - 1]
  hash = JSON.parse(hash_str)



  other_repo_branch_name = hash['other_repo_branch_name'].gsub(/[^0-9a-zA-Z\-_]/, '')


  puts "OTHER_REPO=#{other_repo_branch_name.chomp}"
end

pr_body_settings