# frozen_string_literal: true

module Tinybucket
  module Parser
    extend ActiveSupport::Autoload

    [
      :BaseParser,
      :ObjectParser,
      :CollectionParser
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
