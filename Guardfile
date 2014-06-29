guard 'rspec' , cli: '--drb' do
  watch(%r{^lib/(.+).rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/(.+).rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
