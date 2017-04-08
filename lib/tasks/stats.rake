namespace :stats do
 task :tweets => :environment do
    puts Tweet.count
 end
end