local revision = tonumber(("$Rev: 204 $"):match("(%d+)") or 1)

if CogsUtils and CogsUtils.revision >= revision then
	return
end

CogsUtils = { revision = revision }
local lib = CogsUtils

--[[ Please e-mail localizations to mcogwheel@gmail.com ]]
local L = {
	BAD_ARG = "bad argument #%d to '%s' (%s expected, got %s)"
}

local function checkarg(val, pos, ...)
	if type(pos) ~= "number" then
		argcheck(pos, 2, "number")
	end

	for i=1, select("#", ...) do
		if type(val) == select(i, ...) then return end
	end

	local _, func = debugstack():match(": in function [`'<](.-)['>]")
	error(L.BAD_ARG:format(pos, func, strjoin(", ", ...), type(val)), 3)
end


--[[----------------------------------------------------------------------------
cache = CogsUtils:MakeCache([tbl, ]metamethod)

Makes a cache table which creates new values using the provided metamethod. See
its usage below for examples.

Parameters:
	tbl - table (optional)
		A table to use for the cache. If none is specified, an empty table will
		be created.
	metamethod - function
		A function to determine the default value for a given key. The function
		should accept the new key as its only parameter and return the
		appropriate value.

Returns:
	cache - table
		The same as tbl if provided or the newly created table.
------------------------------------------------------------------------------]]
function lib:MakeCache(tbl, metamethod)
	local pos = 2
	if not metamethod then
		metamethod = tbl
		tbl = nil
		pos = 1
	else
		checkarg(tbl, 1, "table")
	end
	checkarg(metamethod, pos, "function")
	return setmetatable(tbl or {}, {
		__index = function(tbl, key)
			local val = metamethod(key)
			tbl[key] = val
			return val
		end
	})
end



--[[----------------------------------------------------------------------------
funcify = CogsUtils:GetFuncify(func)

Gets a "___ify" function which applies the given operation to all its arguments,
returning multiple values. See stringify as used in CogsUtils:GetPrint below for
an example.

Parameters:
	func - function
		The function to be applied to the arguments.

Returns:
	funcify - function
		The resulting "___ify" function.
------------------------------------------------------------------------------]]
local funcifyFuncs = lib:MakeCache(function(func)
	local function funcify(...)
		if select("#", ...) > 0 then
			return func((...)), funcify(select(2, ...))
		end
	end
	return funcify
end)

function lib:GetFuncify(func)
	checkarg(func, 1, "function")
	return funcifyFuncs[func]
end



--[[----------------------------------------------------------------------------
print = CogsUtils:GetPrint([header])

Gets a print function with an optional header.

Parameters:
	header - string (optional)
		A header to add to any printed output at the beginning of the line.

Returns:
	print - function
		A function that works similarly to Lua's standard print function that
		outputs to DEFAULT_CHAT_FRAME.

Example:
	Code:
		local print = CogsUtils:GetPrint("CogsBar: ")
		print("Hello", 1, nil, false, CogsUtils, print)
	Sample output:
		CogsBar: Hello, 1, nil, false, table: 0x681800, function: 0x6816c0
------------------------------------------------------------------------------]]
local stringify = lib:GetFuncify(tostring)

local printFuncs = lib:MakeCache(function(header)
	if header ~= "" then
		return function(...)
			local first = select("#", ...) == 0 and "" or tostring(...)
			DEFAULT_CHAT_FRAME:AddMessage(strjoin(", ",
				header..tostring(first), stringify(select(2, ...))))
		end
	else
		return function(...)
			DEFAULT_CHAT_FRAME:AddMessage(strjoin(", ", stringify(...)))
		end
	end
end)

function lib:GetPrint(header)
	checkarg(header, 1, "string", "nil")
	header = header or ""
	return printFuncs[header]
end
