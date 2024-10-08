# (c) ANB Andrew Bizyaev
require 'date'
require 'time'

Given(/^empty files named:$/) do |table|
  table.raw.flatten.each do |file|
    step %(an empty file named "#{file}")
  end
end

# ParameterType(
#   name:        'source_folder',
#   regexp:      /(.*?)/,
#   type:        SourceFolder,
#   # The transformer takes as many arguments as there are capture groups in the regexp,
#   # or just one if there are none.
#   transformer: ->(s) { SourceFolder.new(s) }
# )

Given(/^example file "(.*?)" copied to "(.*?)"$/) do |file_in, target_folder|
  basename = File.basename(file_in)
  file_out = File.join(expand_path('.'), target_folder, basename)
  FileUtils.cp(file_in, file_out, preserve: true)
end

# Given(/^example file "(.*?)" copied to file "(.*?)"$/) do |arg1, arg2|
#   file_out = File.join(expand_path('.'), arg2)
#   FileUtils.cp(arg1, file_out, preserve: true)
# end
#
Given(/^example files from "(.*?)" copied to "(.*?)" named:$/) do |source_folder, target_folder, table|
  # table is a Cucumber::Ast::Table
  files = table.raw.flatten
  files.each do |file|
    file_in = File.join(source_folder, file)
    step %(example file "#{file_in}" copied to "#{target_folder}")
  end
end

# Given(/^example file "([^"]*)" with file\-modify\-date set to "([^"]*)"$/) do |arg1, arg2|
#   fmd = Time.parse(arg2)
#   File.utime(fmd, fmd, File.join(expand_path('.'), arg1))
# end

Then('the {channel} should contain each of:') do |channel, table|
  table.raw.flatten.each do |item|
    step %(the #{channel} should contain "#{item}")
  end
end

# # Then(/^the stdout from "(.*?)" should contain each of:$/) do |cmd, table|
# #   # table is a Cucumber::Ast::Table
# #   outs = table.raw.flatten
# #   outs.each do |item|
# #     step %{the stdout from "#{cmd}" should contain "#{item}"}
# #   end
# # end

Then('the {channel} should not contain any of:') do |channel, table|
  table.raw.flatten.each do |item|
    step %(the #{channel} should not contain "#{item}")
  end
end

# Then(/^the output should match each of:$/) do |table|
#   outs = table.raw.flatten
#   outs.each do |item|
#     step %(the output should match #{item})
#   end
# end
#
# # Then(/^the stdout from "(.*?)" should not contain any of:$/) do |cmd, table|
# #   # table is a Cucumber::Ast::Table
# #   outs = table.raw.flatten
# #   outs.each do |item|
# #     step %{the stdout from "#{cmd}" should not contain "#{item}"}
# #   end
# # end
#
# Then(/^the stderr should contain each of:$/) do |table|
#   # table is a Cucumber::Ast::Table
#   outs = table.raw.flatten
#   outs.each do |item|
#     step %(the stderr should contain "#{item}")
#   end
# end
#
# # Then(/^the stderr should not contain any of:$/) do |table|
# #   # table is a Cucumber::Ast::Table
# #   outs = table.raw.flatten
# #   outs.each do |item|
# #     step %{the stderr should not contain "#{item}"}
# #   end
# # end
