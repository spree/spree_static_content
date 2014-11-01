module SpreeStaticContent
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_static_content\n", before: /\*\//, verbose: true
      end

      def add_backend_javascripts
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.js', "//= require spree/backend/spree_static_content"
      end

      def add_tinymce_configuration
        inject_into_file 'config/tinymce.yml' do <<-YML
spree_static_content:
  selector: textarea.tinymce-spree-static-content
  toolbar:
    - styleselect | bold italic | undo redo
    - image | link
  plugins:
    - table
    - code
    - image
    - link
YML
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
