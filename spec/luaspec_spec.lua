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
    exp(function() exp(function() return "nothing" end).should(produce_error()) end).should(produce_error())
  end
end

describe["Equality matcher"] = function()
  it["should return an error when it doesn't match"] = function()
    exp(function() exp(1).should(equal(2)) end).should(produce_error())
  end
end

describe["Should function"] = function()
  it["should call the match method on the matcher"] = function()
    local matcher = mock("matcher")
    matcher.expect_call("match").with("value").and_return(true)
    exp("value").should(matcher)
  end
  it["should raise an error when the matcher returns false"] = function()
    local matcher = mock("matcher")
    matcher.expect_call("match").with("value").and_return(false)
    exp(function() exp("value").should(matcher) end).should(produce_error())
  end
end
