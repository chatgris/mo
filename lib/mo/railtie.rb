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

        # Courtesy of changa.
        desc "Add utf-8 encoding on files that don't have it"
        task :encoding do
          require 'find'
          files_to_convert = []

          Find.find Rails.root.to_s do |f|
            if File.file?(f) && f =~ /\.(rb|feature|rake)$/ && `head -n 1 #{f}|grep '# encoding'`.empty?
              files_to_convert << f
            end
          end

          print "Converting #{files_to_convert.size} files"
          puts if verbose
          files_to_convert.each do |f|
            system "sed -i -r '1 s/^(.*)$/# encoding: utf-8\\n\\1/g' #{f}"
            if verbose
              puts "  * #{f}"
            else
              print '.'
            end
          end
          puts unless verbose

        end
      end
    end
  end
end
