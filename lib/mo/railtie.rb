# encoding: utf-8
module Mo
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.dirname(__FILE__) + '/tasks.rake'
    end
  end
end
