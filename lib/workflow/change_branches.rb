#!/usr/bin/env ruby

require 'json'

REPOS = %w[tweetster-rails-api chess Rails-4-Twitter-Clone]

def remote_branch_exists?
  system("git branch --list $BRANCH_NAME | grep $BRANCH_NAME")
end

def change_branch(repo)
  if remote_branch_exists?
    'git checkout $BRANCH_NAME && git pull'
  else
    puts "branch:$BRANCH_NAME doesn`t exists in repo:#{repo}"
    'echo :sad:'
  end
end

def cd_repo(repo)
  "cd #{File.join(ENV['GITHUB_WORKSPACE'], repo)}"
end

def switch_branches
  REPOS.each do |repo|
    puts "#{'-'*10}#{repo}#{'-'*10}"
    system("#{cd_repo(repo)} && #{change_branch(repo)}")
  end
end

puts ENV.to_h
switch_branches


