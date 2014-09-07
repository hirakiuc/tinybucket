module Tinybucket
  module Model
    module Concerns
      extend ActiveSupport::Autoload

      [
        :RepositoryKeys,
        :Reloadable
      ].each do |mod_name|
        autoload mod_name
      end
    end
  end
end
