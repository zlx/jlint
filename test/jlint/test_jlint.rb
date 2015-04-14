require_relative '../test_helper'

describe Jlint do

  it "should lint for file_path" do
    file_path = File.join(File.dirname(__FILE__), "..", "support", "sample.java")
    result = Jlint.file_lint(file_path)
    assert result.is_a?(Array)
    assert_equal(result.to_yaml, File.read('test/support/sample_errors.yml'))
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
    assert_equal(result.to_yaml, File.read('test/support/custom_config_errors.yml'))
  end

  it "should lint with custom config content" do
    content = %Q[import java.util.*;
public class Sample {
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
  <module name="TreeWalker">
    <module name="AvoidStarImport"/>
  </module>
</module>]
    result = Jlint.new(config_content).lint(content)
    assert result.is_a?(Array)
    assert result.include?(["Using the '.*' form of import should be avoided - java.util.*.", 1])
  end

  it "should error on bad custom config content" do
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
  <module name="AvoidStarImport"/>
</module>]
    assert_raises(RuntimeError) { Jlint.new(config_content).lint(content) }
  end

  it "should error on bad XML" do
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
  <module name="AvoidStarImport"/>
</module]
    assert_raises(RuntimeError) { Jlint.new(config_content).lint(content) }
  end

end
