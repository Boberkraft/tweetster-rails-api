#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess Rails-4-Twitter-Clone]

def switch_branches
  REPOS.each do |repo|
    puts "#{'-'*10}#{repo}#{'-'*10}"
    system("cd $GITHUB_WORKSPACE/#{repo} && git checkout $BRANCH_NAME && git pull")
  end
end

puts ENV.to_h
switch_branches


