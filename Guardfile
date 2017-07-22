# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :minitest, test_folders: '.', test_file_patterns: '*.rb' do
  watch(%r{^(.+)\.rb}) { |m| "./#{m[1]}.rb" }
end

