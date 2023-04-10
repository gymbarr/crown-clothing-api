# frozen_string_literal: true

namespace :env_vars_file do
  desc 'Upload .env file inside config folder'
  task :upload do
    on roles(:app) do
      upload! StringIO.new(File.read('.env.production')), "#{shared_path}/.env.production"
    end
  end
end
