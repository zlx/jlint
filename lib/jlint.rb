require 'tempfile'
require 'yaml'

class Jlint
  def self.lint content
    new.lint content
  end

  def self.file_lint file_path
    new.file_lint file_path
  end


  def initialize custom_config = nil
    @custom_config = custom_config
  end

  def lint content
    as_file content do |file|
      file_lint file.path
    end
  end

  def file_lint file_path
    if @custom_config
      as_file @custom_config, ".xml" do |file|
        parse_lint checkstyle_command, file.path, file_path
      end
    else
      parse_lint checkstyle_command, checkstyle_config, file_path
    end
  end

  private

  def parse_lint command, config_path, file_path
    parse `java -jar #{checkstyle_command} -c #{config_path} #{file_path}`
  end

  def as_file content, format = ".java"
    file = Tempfile.new(["temp", format])
    begin
      file.puts content
      file.rewind
      file.close

      yield file
    ensure
      file.unlink
    end
  end

  def checkstyle_command
    File.join(File.dirname(__FILE__), '..', 'bin', 'current')
  end

  def checkstyle_config
    File.join(File.dirname(__FILE__), '..', 'doc', 'sun_checks.xml')
  end

  def parse results
    array = results.split("\n")
    array.reject! { |s| s == 'Starting audit...' || s == 'Audit done.' }
    array.map! do |msg|
      msgs = msg.split(":")
      [msgs.last.strip, msgs[1].to_i]
    end
  end
end
