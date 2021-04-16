namespace :pm2 do

  desc 'logs'
  task :logs do
    command "pm2 logs NeptuneWeb"
  end

  desc 'Status'
  task :status do
    command "pm2 status"
  end


  desc 'Start Or Restart'
  task :restart do
    in_path fetch(:current_path) do
      command "pm2 startOrRestart ./config/ecosystem.json"
    end
  end

end