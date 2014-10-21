require 'jlint/base'
module Jlint
  def self.lint content, config
    Base.new.lint content, config
  end

  def self.file_lint file_path, config
    Base.new.file_lint file_path, config
  end
end
