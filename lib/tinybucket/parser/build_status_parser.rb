module Tinybucket
  module Parser
    class BuildStatusParser < BaseParser
      def convert(json)
        Tinybucket::Model::BuildStatus.new(json)
      end
    end
  end
end
