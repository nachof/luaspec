describe["exp expression"] = function()
  it["should return a table with a should function"] = function()
    exp(exp("something")).should(be_a("table"))
    exp(exp("something").should).should(be_a("function"))
  end
end
