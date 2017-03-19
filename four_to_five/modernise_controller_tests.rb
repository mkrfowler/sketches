require 'unparser'

class ModerniseControllerTests < Parser::Rewriter
  def on_send(node)
    r, m, *args = node.children
    action, *rest = args

    if m == :get && inferred_old?(rest)
      key = Parser::AST::Node.new(:sym, [:params])
      pair = Parser::AST::Node.new(:pair, [key, *rest])

      new_args = Parser::AST::Node.new(:hash, [pair])
      substitute = Parser::AST::Node.new(:send, [r, m, action, new_args])

      raw_text = Unparser.unparse(substitute)
      subst_text = raw_text.gsub(/\((.*)\)/,' \1')
      
      replace node.location.expression, subst_text
    end

    super
  end

  private

  def inferred_old?(nodes)
    # We have two general situations here (and they are not always
    # unambiguous). The old syntax for these tests takes a series of hash
    # arguments (we have already stripped the required action specifier) -- in
    # sequence, these are parameters, session variables, and flash
    # values. Setting the session is no longer immediate, so let's just solve
    # the simple case where there is a single hash argument -- that does _not_
    # lead with the key

    if nodes.count != 1 # sequential keys are an inferred single hash
      return false # Too many hash args to automate
    elsif nodes.first.children.count != 1
      return true # Clearly not under params!
    end

    # We now need to introspect on the AST...
    pair_elements = nodes.first.children
    key_element   = pair_elements.first.children.first
    if key_element != Parser::AST::Node.new(:sym, [:params])
      # Then we're demonstrably not wrapped under params, now, are we?
      true
    else
      false
    end
  end
end
