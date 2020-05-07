# 配置一下
namespace :db do

  namespace :library do
    desc 'Create library database' # 描述下一个任务
    task create: :environment do
      config = ActiveRecord::Base.configurations[Library::connection_name]

      # Database is null because it hasn't been created yet.
      ActiveRecord::Base.establish_connection(config.merge('database' => nil))
      ActiveRecord::Base.connection.create_database(config['database'], config)
    end


    migration_path = Rails.root.to_s + '/db/library/migrate'

    desc 'Migrate the library database'
    task migrate: :environment do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Library::connection_name])
      # ActiveRecord::Migrator.migrate(migration_path)
      # https://github.com/thiagopradi/octopus/issues/477
      ActiveRecord::MigrationContext.new(migration_path).migrate
    end

    desc 'Rollback the library database'
    task rollback: :environment do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Library::connection_name])
      ActiveRecord::MigrationContext.rollback(migration_path)
    end

  end


end


