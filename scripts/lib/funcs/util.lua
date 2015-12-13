--- Utility functions.

-- Standard library imports --
local clock = os.clock
local getenv = os.getenv
local min = math.min
local pcall = pcall
local print = print
local select = select
local tonumber = tonumber
local type = type

-- Modules --
local af = require("arrayfire")
local array = require("lib.impl.array")

-- Imports --
local Call = array.Call
local CallArr = array.CallArr
local CallWithEnvironment = array.CallWithEnvironment
local CallWithEnvironment_Mode = array.CallWithEnvironment_Mode
local GetHandle = array.GetHandle

-- Exports --
local M = {}

--
local function Print (exp, array, precision)
	Call(af.af_print_array_gen, exp, GetHandle(array), precision or 4) -- https://github.com/arrayfire/arrayfire/blob/devel/src/api/cpp/util.cpp
end

-- --
local T0

--
function M.Add (into)
	for k, v in pairs{
		CallWithEnvironment = CallWithEnvironment,
		CallWithEnvironment_Mode = CallWithEnvironment_Mode,
		CompareResult = array.CompareResult,
		EmptyArray = array.EmptyArray,
		WrapConstant = array.WrapConstant,

		EnvLoopN = function(n, func, ...)
			for _ = 1, n do
				CallWithEnvironment(func, ...)
			end
		end,
		EnvLoopN_Mode = function(n, func, mode, ...)
			for _ = 1, n do
				CallWithEnvironment_Mode(func, mode, ...)
			end
		end,
		EnvLoopWhile = function(func, pred, ...)
			while pred(...) do
				CallWithEnvironment(func, ...)
			end
		end,
		EnvLoopWhile_Mode = function(func, pred, mode, ...)
			while pred(...) do
				CallWithEnvironment(func, mode, ...)
			end
		end,
		EnvLoopUntil = function(func, pred, ...)
			repeat
				CallWithEnvironment(func, ...)
			until pred(...)
		end,
		EnvLoopUntil_Mode = function(func, pred, mode, ...)
			repeat
				CallWithEnvironment_Mode(func, mode, ...)
			until pred(...)
		end,
		getDims = function(arr, out)
			out = out or {}

			out[1], out[2], out[3], out[4] = CallArr(af.af_get_dims, arr)

			return out
		end,
		main = function(func, ...)
			local argc, argv = select("#", ...), { ... }

			for i = 1, argc do -- Mimic C array
				argv[i - 1] = argv[i]
			end

			argv[argc] = nil

			local ok, err = pcall(function()
				local device = argc > 1 and tonumber(argv[1]) or 0

				-- Select a device and display arrayfire info
				af.af_set_device(device)
				af.af_info()

				func(argc, argv)

				if getenv("windir") ~= nil then -- pause in Windows
					if not (arc == 2 and argv[1]:sub(1, 1) == "-") then
						print("hit [enter]...")
						io.output():flush()
						-- getchar() io.input():read()?
					end
				end
			end)

			if not ok then
				print(err) -- TODO: more informative
				-- throw
			end
		end,
		numDims = function(arr)
			return CallArr(af.af_get_numdims, arr)
		end,
		print = Print,
		printf = function(s, ...)
			print(s:format(...))
		end,
		timeit = function(func)
			local t0 = clock()

			func()

			return clock() - t0
		end,
		timer_start = function()
			T0 = clock()
		end,
		timer_stop = function()
			return clock() - T0
		end
		-- ^^^ TODO: Better stuff?
	} do
		into[k] = v
	end
end

-- Export the module.
return M