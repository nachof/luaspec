local function mock_mt(name)
  local mt = {}
  mt.__expected_calls = {}
  mt.__index = function(some_mock, some_method)
    for _,m in ipairs(mt.__expected_calls) do
      if m == some_method then
        return function() end
      else
        error("Mock " .. name .. " received unexpected message " .. some_method)
      end
    end
  end
  return mt
end

function mock(name)
  local m = {}
  name = name or tostring(m)
  local mt = mock_mt(name)
  setmetatable(m, mt)
  m.expect_call = function(method)
    mt.__expected_calls[#(mt.__expected_calls)+1] = method
  end
  return m
end
