local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

local function replicate(args)
	return args[1]
end

-- Define the rpc snippet
ls.add_snippets("proto", {
	s(
		"rpc",
		fmt(
			[[
rpc {} ({}Request) returns ({}Response);
message {}Request {{}}
message {}Response {{}}
                ]],
			{
				i(1, "param"),
				f(replicate, { 1 }),
				f(replicate, { 1 }),
				f(replicate, { 1 }),
				f(replicate, { 1 }),
			}
		)
	),
})
