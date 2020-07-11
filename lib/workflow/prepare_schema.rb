#!/usr/bin/env ruby


case ENV['REPOSITORY_NAME']
when 'chess'
  system('cp $GITHUB_WORKSPACE/Rails-4-Twitter-Clone/db/schema.rb-ci $GITHUB_WORKSPACE/chess/db/schema.rb')
when 'tweetster-rails-api'
  system('cp $GITHUB_WORKSPACE/Rails-4-Twitter-Clone/db/schema.rb-ci $GITHUB_WORKSPACE/tweetster-rails-api/db/schema.rb')
when 'Rails-4-Twitter-Clone'
  system('cp $GITHUB_WORKSPACE/Rails-4-Twitter-Clone/db/schema.rb-ci $GITHUB_WORKSPACE/Rails-4-Twitter-Clone/db/schema.rb')
else
  raise '???'
end
