class Lisp
  def self.eval(expr)
    tokens = expr.gsub("(", " ( ")
               .gsub(")", " ) ")
               .split

    parse(tokens)
  end

  def self.parse(tokens)
    token = tokens.shift

    if token == "("
      op = tokens.shift

      args = []

      until tokens.first == ")"
        args << parse(tokens)
      end

      tokens.shift

      case op
      when "+"
        args.sum
      when "-"
        args.reduce(:-)
      when "*"
        args.reduce(:*)
      when "/"
        args.reduce(:/)
      end
    else
      if token.match?(/\A-?\d+\z/)
        token.to_i
      else
        raise "Invalid token: #{token}"
      end
    end
  end
end
