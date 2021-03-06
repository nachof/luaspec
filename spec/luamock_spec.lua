describe["mock function"] = function()
  it["should return a table"] = function()
    exp(mock("test")).should(be_a("table"))
  end
end

describe["A mock"] = function()
  it["should raise an error when a function is called on it"] = function()
    local m = mock("test")
    exp(function() m.method() end).should(produce_error())
  end
  it["should be possible to specify a function to be called"] = function()
    local m = mock("test")
    m.expect_call("method")
    exp(function() m.method() end).should_not(produce_error())
    exp(function() m.other_method() end).should(produce_error())
  end
  it["should be possible to specify a return value"] = function()
    local m = mock("test")
    m.expect_call("method").and_return("value")
    exp(m.method()).should(equal("value"))
  end
  it["should be possible to specify an argument"] = function()
    local m = mock("test")
    m.expect_call("method").with("param")
    m.method("param")
    exp(function() m.method() end).should(produce_error())
    exp(function() m.method("param") end).should_not(produce_error())
  end
end
