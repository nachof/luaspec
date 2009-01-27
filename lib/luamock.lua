local function mock_mt(name)
  local mt = {}
  mt.__expected_calls = {}
  mt.__index = function(some_mock, some_method)
    for _,c in ipairs(mt.__expected_calls) do
      if c.method == some_method then
        return function() return c.return_value end
      else
        error("Mock " .. name .. " received unexpected message " .. some_method)
      end
    end
  end
  return mt
end

local function mock_call_modifier(call)
  local modifier = {}
  modifier.and_return = function(value)
    call.return_value = value
    return modifier
  end
  return modifier
end

function mock(name)
  local m = {}
  name = name or tostring(m)
  local mt = mock_mt(name)
  setmetatable(m, mt)
  m.expect_call = function(method)
    local call = {method=method}
    mt.__expected_calls[#(mt.__expected_calls)+1] = call
    return mock_call_modifier(call)
  end
  return m
end
