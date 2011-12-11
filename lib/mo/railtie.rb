# encoding: utf-8
module Mo
  class Railtie < Rails::Railtie
    rake_tasks do
      extend Rake::DSL

      namespace :mo do

        desc "Clean-up trailing whitespaces."
        task :whitespace do
          globs = %w[ app/**/*.rb app/**/*.haml app/**/*.js app/**/*.coffee lib/**/*.rb spec/**/*.rb lib/**/*.rake Gemfile config/**/*.rb config/**/*.yml]
          globs.map { |glob| Dir[glob] }.flatten.each do |file|
            puts file
            system "sed -e 's/[ \t]*$//' -i #{file}"
          end
        end
      end
    end
  end
end
