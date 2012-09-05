# encoding: utf-8
require 'boson/runner'

module Mo
  class Runner < Boson::Runner
    RUBY_FILES = %w[**/*.haml **/*.ru **/*.rake Gemfile **/*.rb]
    JS_FILES   = %w[**/*.js **/*.coffee]

    desc "Clean-up trailing whitespaces."
    def whitespace
      (RUBY_FILES + JS_FILES).map { |glob| Dir[glob] }.flatten.each do |file|
        wsps = false
        File.open(file).each_line do |line|
          break if wsps = line.match(/( |\t)*$/).captures.compact.any?
        end
        if wsps
          system "sed -e 's/[ \t]*$//' -i #{file}"
          puts "  * #{file}"
        end
      end
    end

    desc "Convert ruby hashes to 1.9 style."
    def rocketless
      RUBY_FILES.map { |glob| Dir[glob] }.flatten.each do |file|
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
    def encoding
      RUBY_FILES.map { |glob| Dir[glob] }.flatten.each do |file|
        if `head -n 1 #{file}|grep '# encoding'`.empty?
          system "sed -i -r '1 s/^(.*)$/# encoding: utf-8\\n\\1/g' #{file}"
          puts "  * #{file}"
        end
      end
    end
  end
end
