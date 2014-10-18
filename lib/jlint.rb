class Jlint
  def lint file_path, config
    # system("java -jar ~/code/mine/jlint/checkstyle.jar -c ~/code/mine/jlint/doc/sun_checks.xml ~/Documents/AnimationFunctions.java")
    results = system("java -jar #{../checkstyle.jar} -c #{../doc/sun_checks.xml} #{file_path}")
  end
end
