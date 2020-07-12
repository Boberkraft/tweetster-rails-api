#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess Rails-4-Twitter-Clone]

$branch = ENV['BRANCH_NAME']

def remote_branch_exists?
  system("git branch --list #{$branch}| grep #{$branch}")
end

def change_branch_cmd
  if remote_branch_exists?
    'git checkout $branch && git pull'
  else
    'cat ":sad:"'
  end
end

def cd_repo(repo)
  "cd #{File.join(ENV['GITHUB_WORKSPACE'], repo)}"
end

def switch_branches
  REPOS.each do |repo|
    system("#{cd_repo(repo)} && #{change_branch_cmd}")
  end
end

puts ENV.to_h
switch_branches


