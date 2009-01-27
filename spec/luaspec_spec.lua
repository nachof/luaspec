describe["Expression wrapper"] = function()
  it["should return a table with a should function"] = function()
    exp(exp("something")).should(be_a("table"))
    exp(exp("something").should).should(be_a("function"))
  end
end

describe["Error matcher"] = function()
  it["should detect when an error has been produced"] = function()
    exp(function() error("Boom") end).should(produce_error())
  end
  it["should produce an error when no error has been produced"] = function()
    exp(exp(function() return "nothing" end).should(produce_error())).should(produce_error())
  end
end

describe["Equality matcher"] = function()
  it["should return an error when it doesn't match"] = function()
    exp(function() exp(1).should(equal(2)) end).should(produce_error())
  end
end
