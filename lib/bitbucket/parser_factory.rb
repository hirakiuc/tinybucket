module Bitbucket
  class ParserFactory
    class << self
      def create_instance(path)
        return nil unless path =~ %r{\A/api/2.0(/.+)\Z}

        suffix = $1
        klass = get_class(suffix)

        klass.new
      end

      def get_class(path)

        case path
        when %r{\A/repositories(/.+)?\Z}
          # page & Repositories
        end
      end
    end
  end
end
