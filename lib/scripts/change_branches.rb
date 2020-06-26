#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess]

def remote_branch_exists?
  branch = ENV['BRANCH_NAME']
  system("git branch --list #{b}| grep #{branch}")
end

def switch_branches
  REPOS.each do |repo, branch_name|
    `cd #{repo}`
    `git checkout #{branch_name}` if remote_branch_exists?
  end
end


switch_branches


