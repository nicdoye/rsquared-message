# An RFC 1035 Message

=begin
4. MESSAGES

4.1. Format

All communications inside of the domain protocol are carried in a single
format called a message.  The top level format of message is divided
into 5 sections (some of which are empty in certain cases) shown below:

    +---------------------+
    |        Header       |
    +---------------------+
    |       Question      | the question for the name server
    +---------------------+
    |        Answer       | RRs answering the question
    +---------------------+
    |      Authority      | RRs pointing toward an authority
    +---------------------+
    |      Additional     | RRs holding additional information
    +---------------------+
=end

require_relative 'header'
require_relative 'question'
require_relative 'version'

module RSquared
  class Message
    @bytes
    @header
    @question

    HEADER_BYTES = 12

    def header
      @header = Header.new(@bytes.slice(0, HEADER_BYTES)) if @header.nil?
      return @header
    end

    def question
      @question = Question.new(@bytes.slice(HEADER_BYTES, @bytes.length - HEADER_BYTES )) if @question.nil?
      return @question
    end

# Need to write these properly
# Setting any part means invalidating @bytes
# Should we allow creation in a random order (think about that: question is of an arbitrary length)
# Or fake an overloaded initializer() viz. def initialize( *args ) .. case args.size .. when 1 .. when 5

    def header=(header)
      @header = header
    end

    def question=(question)
      @question = question
    end

    def hexdump
      @bytes.hexdump do |index,hex,printable|
        print "Index #{index}"
        print ' '
        print "HEX: #{hex}"
        print ' '
        puts "Printable: #{printable}"
      end
    end

    def initialize(bytes)
      @bytes = bytes
    end
  end
end
