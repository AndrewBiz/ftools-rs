# (c) ANB Andrew Bizyaev
require 'date'
require 'time'

Given(/^empty files named:$/) do |table|
  table.raw.flatten.each do |file|
    step %(an empty file named "#{file}")
  end
end

# Given(/^example file "(.*?)" copied to "(.*?)"$/) do |arg1, arg2|
#   basename = File.basename(arg1)
#   file_out = File.join(expand_path('.'), arg2, basename)
#   FileUtils.cp(arg1, file_out, preserve: true)
# end
#
# Given(/^example file "(.*?)" copied to file "(.*?)"$/) do |arg1, arg2|
#   file_out = File.join(expand_path('.'), arg2)
#   FileUtils.cp(arg1, file_out, preserve: true)
# end
#
# Given(/^example files from "(.*?)" copied to "(.*?)" named:$/) do |arg1, arg2, table|
#   # table is a Cucumber::Ast::Table
#   files = table.raw.flatten
#   files.each do |file|
#     file_in = File.join(arg1, file)
#     step %(example file "#{file_in}" copied to "#{arg2}")
#   end
# end
#
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
#
# Then(/^the stdout should not contain any of:$/) do |table|
#   # table is a Cucumber::Ast::Table
#   outs = table.raw.flatten
#   outs.each do |item|
#     step %(the stdout should not contain "#{item}")
#   end
# end
#
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
