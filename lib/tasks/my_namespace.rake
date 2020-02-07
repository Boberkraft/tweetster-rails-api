require 'json'
require 'open3'

namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    begin
      file = File.read(File.join(ENV['HOME'], 'files_modified.json'))
      data_hash = JSON.parse(file)
    rescue
      data_hash = [Rails.root]
    end
    puts data_hash

    stdout, stdeerr, status = Open3.capture3("RAILS_ENV=development bundle exec rspec -f j /Users/macos/tweetster-rails-api")

    output = JSON.parse(stdout)
    out = output['examples'].each_with_object({}) { |item, obj| obj[item['status']] = obj.fetch(item['status'], []) << item['full_description'] }

    if File.exists?(File.join(ENV['HOME'], 'difference.txt'))
      # 2 time

      master_output = JSON.parse(File.read(File.join(ENV['HOME'], 'difference.txt')))

      master_failed = master_output["failed"].to_a
      this_failed = out["failed"].to_a


      diff = this_failed - master_failed

      if diff != []
        puts
        puts
        group.each { |g| puts "#{FAIL}!!! - #{g}"}
        raise "DUPA KAMIENI KUPA"
      end

    else
      # 1 time
      File.open(File.join(ENV['HOME'], 'difference.txt')) do |f|
        f.write(out.to_json)
      end
    end


    out.each do |status, group|
      group.each { |g| puts "#{status} - #{g}"}
    end
  end
end
