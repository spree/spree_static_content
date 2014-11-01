module SpreeStaticContent
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      source_root File.expand_path("../templates", __FILE__)

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_static_content\n", before: /\*\//, verbose: true
      end

      def add_backend_javascripts
        inject_into_file 'vendor/assets/javascripts/spree/backend/all.js', after: "//= require spree/backend" do
          "\n//= require spree/backend/spree_static_content"
        end
      end

      def add_tinymce_configuration
        copy_file 'tinymce.yml', 'config/tinymce.yml.spree_static_content'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_static_content'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
