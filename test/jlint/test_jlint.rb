require_relative '../test_helper'

describe Jlint do

  it "should lint for file_path" do
    file_path = File.join(File.dirname(__FILE__), "..", "support", "sample.java")
    result = Jlint.file_lint(file_path, "")
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
}
    ]
    result = Jlint.lint(content, "")
    assert result.is_a?(Array)
    assert result.include?(["Missing package-info.java file.", 0])
  end

end
