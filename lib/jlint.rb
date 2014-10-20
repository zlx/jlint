require 'jlint/base'
module Jlint
  def self.lint file_path, config
    Base.new.lint file_path, config
  end
end
