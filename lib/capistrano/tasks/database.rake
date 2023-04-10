# frozen_string_literal: true

namespace :database do
  desc 'Create the database'
  task :create do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  desc 'Create seed data'
  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
