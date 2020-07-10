#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess Rails-4-Twitter-Clone]

def remote_branch_exists?
  branch = ENV['BRANCH_NAME']
  system("git branch --list #{branch}| grep #{branch}")
end

def switch_branches
  REPOS.each do |repo|
    puts ENV.to_h
    puts `tree #{ENV['GITHUB_WORKSPACE']}`
    puts File.join(ENV['GITHUB_WORKSPACE'], repo)
    system("#{File.join(ENV['GITHUB_WORKSPACE'], repo)} && #{remote_branch_exists? ? ENV['BRANCH_NAME'] : 'cat "a"' }")
  end
end


switch_branches


