# encoding: utf-8
require 'boson/runner'

module Mo
  class Runner < Boson::Runner
    RUBY_FILES = %w[**/*.ru **/*.rake Gemfile **/*.rb]
    SPEC_FILES = %w[spec/**/*.rb]
    JS_FILES   = %w[**/*.js **/*.coffee]
    TPL_FILES  = %w[**/*.haml **/*.erb **/*.slim **/*.jade]
    DOC_FILES  = %w[**/*.md **/*.txt **/*.textile]
    ALL_FILES  = RUBY_FILES + JS_FILES + DOC_FILES + TPL_FILES

    desc "Clean-up trailing whitespaces."
    def whitespace
      Dir[*ALL_FILES].each do |file|
        wsps = false
        begin
          File.open(file).each_line do |line|
            break if wsps = line.match(/( |\t)*$/).captures.compact.any?
          end
          if wsps
            system "sed -e 's/[ \t]*$//' -i #{file}"
            puts "  * #{file}"
          end
        rescue Errno::EISDIR
        end
      end
    end

    desc "Print files with more than 80 columns"
    def eighty_column
      Dir[*ALL_FILES].each do |file|
        output = `grep -n '.\\{80,\\}' #{file}`
        unless output.empty?
          puts file
          puts output
        end
      end
    end

    desc "Convert ruby hashes to 1.9 style."
    def rocketless
      Dir[*RUBY_FILES].each do |file|
        source = File.open(file).read
        regexp = /(?<!return)(?<!:)(?<!\w)(\s+):(\w+)\s*=>/
        next if source.scan(regexp).any?
        source.gsub!(regexp, '\1\2:')
        open(file, 'w') { |b| b << source }
        puts "  * #{file}"
      end
    end

    # Courtesy of changa.
    desc "Add utf-8 encoding on files that don't have it"
    def encoding(listener = Kernel)
      Dir[*RUBY_FILES].each do |file|
        if `head -n 2 #{file} | grep -E '# encoding\|-\*- coding'`.empty?
          listener.system "sed -i -r '1 s/^(.*)$/# encoding: utf-8\\n\\1/g' #{file}"
          puts "  * #{file}"
        end
      end
    end

    desc "Check ruby syntax."
    def check_syntax
      Dir[*RUBY_FILES].each do |file|
        if File.readable? file
          puts "  * #{file}"
          puts `#{which('ruby')} -wc #{file}`.chomp
        end
      end
    end

    desc "Check rspec's files name"
    def check_rspec_files_name(listener = Kernel)
      ignores_dirs = %w[spec/factories spec/mocks spec/support spec/fabricators
      spec/fixtures spec/spec_helper.rb]
      Dir[*SPEC_FILES].each do |file|
        next if file.match(/_spec.rb$/)
        listener.puts " * #{file}" unless ignores_dirs.any? {|dir| file.include?(dir) }
      end
    end

    private

    # Cross-platform way of finding an executable in the $PATH.
    # Taken from
    # http://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
    #
    #   which('ruby') #=> /usr/bin/ruby
    def which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
          exe = "#{path}/#{cmd}#{ext}"
          return exe if File.executable? exe
        }
      end
      return nil
    end
  end
end
