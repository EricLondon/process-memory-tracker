namespace :monitor do
  desc "Monitor process memory"
  task process_memory: :environment do
    ProcessMemoryService.new.run
  end
end
