require "fileutils"

Dir[File.join(File.dirname(__FILE__), "..", "**", "protoc")].each do |file|
  FileUtils.chmod 0755, file
end