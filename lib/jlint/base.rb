module Jlint
  class Base
    def initialize
    end

    def lint file_path, config
      parse `java -jar #{checkstyle_command} -c #{checkstyle_config} #{file_path}`
    end

    private
    def checkstyle_command
      File.join(File.dirname(__FILE__), '..', '..', 'bin', 'checkstyle.jar')
    end

    def checkstyle_config
      File.join(File.dirname(__FILE__), '..', '..', 'doc', 'sun_checks.xml')
    end

    def parse results
      array = results.split("\n")
      array.reject! { |s| s == 'Starting audit...' || s == 'Audit done.' }
      array.map! do |msg|
        msgs = msg.split(":")
        [msgs.last.strip, msgs[1]]
      end
    end
  end
end
