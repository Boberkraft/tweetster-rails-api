#!/usr/bin/env ruby

require 'json'

# https://stackoverflow.com/questions/2660571/exporting-an-environment-variable-in-ruby


PARSED_FILE = File.join(ENV['HOME'], 'parsed_pr.txt')


def test_pr_body
  '
Siemaneczko tutaj moj super pullrequest na branchu .
resolves https://github.com/server/server/server/8583#event-3148730158
chess: https://github.com/server/server/das
parser:  https://github.com/server/server/das
server: https://github.com/server/server/das
server_branch: jakis_dziwny_branch

a tutaj coś dodatkowego
'
end

CUSTOM_BRANCH_NAME = 'test'

def branch_name
  return CUSTOM_BRANCH_NAME if CUSTOM_BRANCH_NAME
  ENV['GITHUB_REF'] && ENV['GITHUB_REF'].split('/')[2]
end


PERMITED = {
  chess: %w[chesses w_chess jb_chess],
  parser: %w[parser],
  pilont: %w[falafel],
  server: %w[]
}

def find_proper_name(name)
  PERMITED.each do |proper, aliases|
    proper = proper.to_s
    return proper if name == proper || aliases.include?(name)
  end

  raise "No proper name for #{name} ???"
end

def pr_body_settings
  body = ENV['PR_BODY'] || test_pr_body

  repos = {}

  body.scan(/([a-z_]+):\s+([^\s]+)/) do |repo, _url|
    next if repo.to_s.end_with?('_branch')
    repos[find_proper_name(repo)] = branch_name
  end

  body.scan(/([a-z_]+)_branch:\s+([^\s]+)/) do |repo, branch_name|
    repos[find_proper_name(repo)] = branch_name
  end

  puts repos
  File.open(PARSED_FILE, 'w') do |f|
    f.write(repos.to_json)
  end
end

pr_body_settings