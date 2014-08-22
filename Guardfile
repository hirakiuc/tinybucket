guard 'rspec', cmd: 'rspec --drb' do
  watch(/^spec\/.+_spec\.rb$/)
  watch(/^lib\/(.+)\.rb$/)  { |m| "spec/#{m[1]}_spec.rb" }
  watch(/^spec\/(.+)\.rb$/) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }

  watch(/^lib\/(.+)\.rb$/) { |m| "spec/#{m[1]}_spec.rb" }
end

guard :rubocop, all_on_start: true, cmd: ['--format', 'clang', '-c', '.rubocop.yml'] do
  watch(/^lib\/(.+)\.rb$/)
  watch(/\.rubocop.yml$/)
end
