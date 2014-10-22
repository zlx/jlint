require_relative '../test_helper'

describe Jlint do

  it "should lint for file_path" do
    file_path = File.join(File.dirname(__FILE__), "..", "support", "sample.java")
    result = Jlint.file_lint(file_path)
    assert result.is_a?(Array)
    assert result.include?(["Missing package-info.java file.", 0])
  end

  it "should lint for file content with newline" do
    content = %Q[public class Sample {
  public static void Sample() {
  }

  public void hi(long name) {
    system.out.printf("Hi, " + name);
  }
}]
    result = Jlint.lint(content)
    assert result.is_a?(Array)
    assert !result.include?(["File does not end with a newline.", 0])
    assert result.include?(["Missing package-info.java file.", 0])
  end

  it "should lint with custom config content" do
    content = %Q[public class Sample {
  public static void Sample() {
  }

  public void hi(long name) {
    system.out.printf("Hi, " + name);
  }
}]
    config_content = %Q[<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
          "-//Puppy Crawl//DTD Check Configuration 1.3//EN"
          "http://www.puppycrawl.com/dtds/configuration_1_3.dtd">
<module name="Checker">
</module>]
    result = Jlint.new(config_content).lint(content)
    assert result.is_a?(Array)
    assert !result.include?(["Missing package-info.java file.", 0])
  end

end
