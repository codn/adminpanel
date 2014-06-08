module Adminpanel
  module MigrationGeneratorHelper

    def migration_name
      migration_name_parts = name.underscore.split('_')
      prefix_table = migration_name_parts[(migration_name_parts.size - 2)] # to get 'adminpanel' if exists
      if prefix_table != 'adminpanel'
        table_name = migration_name_parts.pop
        migration_name_parts << 'adminpanel' << table_name
      end
      return migration_name_parts.join('_')
    end

    def resource_migrating
      resource_name = name.underscore.split('_').pop.singularize
    end

  end
end
