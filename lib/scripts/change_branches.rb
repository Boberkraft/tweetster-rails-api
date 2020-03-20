#!/usr/bin/env ruby

require 'json'

PARSED_FILE = File.join(ENV['HOME'], 'parsed_pr.txt')

def get_parsed_pr
  raise 'No parsed pr!' unless File.exists?(PARSED_FILE)
  JSON.parse(File.read(PARSED_FILE))
end



def switch_branches(repos_with_branches)
  repos_with_branches.each do |repo, branch_name|
    `cd #{File.join(ENV['HOME'], repo)}`
    `git checkout #{branch_name}`
  end
end


switch_branches(get_parsed_pr)


