# Supported Operators
# ⟹, ⟺
# ∧, ∨
# ¬
# ∃, ∀
#------------------------------------------------------
require "./dependencies"

# inputs = [ "∃x[P(x)∧∀x[Q(x)⟹¬P(x)]]", "∀x[P (x) ⟺ (Q(x) ∧ ∃y[Q(y) ∧ R(y, x)])]", "B(a)", "¬P (x) ∧ Q(z)" ]

parser = Parser.new
sentence = "∀x[P(x) ∧ Q(x) ⟺ Z(x)]"
parsedSentence = parser.parse_sentence(sentence)

puts parsedSentence.inspect

# puts parsedSentence.resolve.inspect

CNF.execute(parsedSentence, true)

# p parsedSentence.pretty_print

# -----------------------
# p1 = Predicate.new("P", [VariableTerm.new("x"), VariableTerm.new("y"), FunctionTerm.new("f", [VariableTerm.new("x")])])
# # puts p.pretty_print

# p2 = Predicate.new("P", [VariableTerm.new("x"), VariableTerm.new("y"), FunctionTerm.new("f", [VariableTerm.new("x")])])

# andS = And.new(p1,p2)
# orS = Or.new(p1, p2)

# puts "-----------"
# puts andS.inspect
# puts "-----------"
# puts andS.sentence1
# puts "-----------"
# x = andS.step_1
# x.sentence1.terms = []
# puts x.inspect
# puts "-----------"

# fAll = ThereExists.new("s", p1)
# p andS.pretty_print
# p orS.pretty_print
# p fAll.pretty_print