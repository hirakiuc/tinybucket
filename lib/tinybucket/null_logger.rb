module Tinybucket
  class NullLogger
    attr_accessor :level

    def fatal(_progname = nil, &_block); end

    def fatal?
      false
    end

    def error(_progname = nil, &_block); end

    def error?
      false
    end

    def warn(_progname = nil, &_block); end

    def warn?
      false
    end

    def info(_progname = nil, &_block); end

    def info?
      false
    end

    def debug(_progname = nil, &_block); end

    def debug?
      false
    end
  end
end
