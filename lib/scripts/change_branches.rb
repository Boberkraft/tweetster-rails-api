#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess]

def remote_branch_exists?
  branch = ENV['BRANCH_NAME']
  system("git branch --list #{b}| grep #{branch}")
end

def switch_branches
  REPOS.each do |repo|
    puts ENV.to_h
    `cd #{File.join(ENV['MY_PATH'], repo)}`
    `git checkout #{ENV['BRANCH_NAME']}` if remote_branch_exists?
  end
end


switch_branches


