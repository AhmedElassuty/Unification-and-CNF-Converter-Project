class Term 
  attr_accessor :name, :terms 

  @@funcNames  = []
  @@constNames = []
  @@varNames   = []
  
  ## Class Constructor
  def initialize(name, terms)
    @name = name
    @terms = terms 
  end

  ## Class Pretty Printer
  def pretty_print
    @name
  end

  def equals?(atom)
    if self.instance_of?(atom.class)
      return self.name == atom.name
    end
    return false
  end

  def self.funcNames
    @@funcNames
  end

  def self.varNames
    @@varNames
  end

  def self.constNames
    @@constNames
  end

  def self.reset
    @@funcNames  = []
    @@constNames = []
    @@varNames   = []
  end

end

class ConstantTerm < Term 

  ## Class Constructor
  def initialize(name)
    @@constNames << name
    super(name, nil)
  end

  def step_5(variables, toBeReplaced)
    self.clone
  end

  def get_used_variables
    @name
  end
end

class VariableTerm < Term
    
  ## Class Constructor
  def initialize(name)
    @@varNames << name
    super(name, nil)
  end

  def step_5(variables, toBeReplaced)
    return self.clone unless toBeReplaced.map { |t| t[:var] }.include? self.name
    obj = toBeReplaced.detect { |v| v[:var].eql? self.name }
    if obj[:bounded]
      terms = variables.map { |var| VariableTerm.new(var)}
      FunctionTerm.new(obj[:func_name], terms)
    else
      if obj[:replacedBy].nil?
        freeConstants = [*('A'..'Z')] - Term.constNames
        obj[:replacedBy] = freeConstants.last
      end
      ConstantTerm.new(obj[:replacedBy])
    end
  end

  def get_used_variables
    @name
  end
end

class FunctionTerm < Term

  ## Class Constructor
  def initialize(name, terms)
    @@funcNames << name
    super(name, terms)
  end

  ## Class Pretty Printer
  def pretty_print
    @name + LEFT_PARENTHESIS_SYMBOL + @terms.map { |t| t.pretty_print}.join(",") + RIGHT_PARENTHESIS_SYMBOL
  end

  def step_5(variables, toBeReplaced)
    term = self.clone
    term.terms = @terms.map { |t| s = t.clone; t.step_5(variables.clone, toBeReplaced.clone)}
    term
  end

  def get_used_variables
    @terms.map { |t| t.get_used_variables }
  end

  def equals?(atom)
    if self.instance_of?(atom.class)
      if self.name == atom.name && self.terms.count == atom.terms.count
        self.terms.each_with_index do |term, index|
          return false unless term.equals?(atom.terms[index])
        end
      else
          return false
      end
      return true
    end
    return false
  end
end