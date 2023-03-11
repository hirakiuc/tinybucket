# frozen_string_literal: true

module Tinybucket
  module Encoder
    extend ActiveSupport::Autoload
    [
      :ApiParamsEncoder
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
