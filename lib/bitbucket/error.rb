module Bitbucket
  module Error
  end
end

%w(base_error service_error).each do |name|
  require 'bitbucket/error/' + name
end
