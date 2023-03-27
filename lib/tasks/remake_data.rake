require "rake"
namespace :db do
  desc "task description"
  task remake_data: :environment do
    %w(db:migrate:reset db:seed).each do |task|
      p "start progess"
      Rake::Task[task].invoke
      p "successful"
    end
  end
end
