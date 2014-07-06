guard 'rspec' , cmd: 'rspec --drb' do
  watch(%r{^lib/(.+)\.rb$})  { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
end

guard :rubocop, all_on_start: true, cmd: ['--format', 'clang', '-c', '.rubocop.yml'] do
  watch(%r{^lib/(.+)\.rb$})
  watch(%r{\.rubocop.yml$})
end
