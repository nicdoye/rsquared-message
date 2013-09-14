=begin
4.1.2. Question section format

The question section is used to carry the "question" in most queries,
i.e., the parameters that define what is being asked.  The section
contains QDCOUNT (usually 1) entries, each of the following format:

                                    1  1  1  1  1  1
      0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                                               |
    /                     QNAME                     /
    /                                               /
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                     QTYPE                     |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                     QCLASS                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

where:

QNAME           a domain name represented as a sequence of labels, where
                each label consists of a length octet followed by that
                number of octets.  The domain name terminates with the
                zero length octet for the null label of the root.  Note
                that this field may be an odd number of octets; no
                padding is used.

QTYPE           a two octet code which specifies the type of the query.
                The values for this field include all codes valid for a
                TYPE field, together with some more general codes which
                can match more than one type of RR.

QCLASS          a two octet code that specifies the class of the query.
                For example, the QCLASS field is IN for the Internet.

=end

module RSquared
  class Message
    class Question
      @bytes
      @qname
      @length
    
      def qname
        return @qname unless @qname.nil?
    
        length = 0
        qname = ""
        remain = 0
        @bytes.each_byte do |b|
          length += 1
    
          # Found a null terminator \0
          break if b.ord == 0
      
          # Finished with a word. 
          # This is the separator - which is the count of chars in next word
          if remain == 0
            remain = b.ord
            qname << "." unless qname.empty?
            next
          end
    
          # Add individual char on end of qname (we could do this a component at a time)
          qname << b
          remain -= 1
        end
        
        # Atomically set @gname
        @qname = qname
    
        # Length of entire Question is qname length + qtype length + qclass length
        @length = length + 4
    
        @qname
      end
    
      def qtype
        qname if @length.nil?
        
        @bytes.slice(@length, 2)
      end
    
      def qclass
        qname if @length.nil?
        
        @bytes.slice(@length + 2, 2)
      end
    
      def initialize(bytes)
        @bytes = bytes
      end
    end
  end
end
