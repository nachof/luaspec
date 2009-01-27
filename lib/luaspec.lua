describe = {}
it = {}

local errors = {}
local all_errors = {}


function exp(expression)
  local table = {expression=expression}
  table.should = function(matcher)
    if not matcher.match(expression) then
      local info = debug.getinfo(2, Sl)
      local location = info.source .. ":" .. info.currentline .. ": "
      errors[#errors + 1] = location .. matcher.message
    end
  end
  return table
end

local function showvalue(value)
  if type(value) == "string" then
    return string.format("%q", value)
  else
    return tostring(value)
  end
end

local function print_errors(whaterrors, prefix)
  prefix = prefix or ""
  whaterrors = whaterrors or all_errors
  for n,e in pairs(whaterrors) do
    if type(e) == "table" then
      local newprefix = ((prefix ~= "") and (prefix .. " ") or "") .. n
      print_errors(e, newprefix)
    else
      print(prefix .. ":\n\t" .. e)
    end
  end
end

function run_tests()
  for name,description in pairs(describe) do
    it = {}
    description()
    for it_name,behavior in pairs(it) do
      all_errors[name] = all_errors[name] or {}
      all_errors[name][it_name] = all_errors[name][it_name] or {}
      errors = all_errors[name][it_name]
      behavior()
    end
  end
  print_errors()
end

--
-- Matchers
--

function equal(element)
  local matcher = {}
  matcher.message = "Expected " .. showvalue(element) .. " but got "
  matcher.match = function(what)
    if what == element then
      return true
    else
      matcher.message = matcher.message .. showvalue(what)
      return false
    end
  end
  return matcher
end

function have_type(t)
  local matcher = {}
  matcher.match = function(what)
    if type(what) == t then
      return true
    else
      matcher.message = "Expected " .. showvalue(what) .. " to be of type " .. t .. " but it was of type " .. type(what)
      return false
    end
  end
  return matcher
end

be_a = have_type