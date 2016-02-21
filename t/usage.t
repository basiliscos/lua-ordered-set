#!/usr/bin/env lua

require 'Test.More'
local OrderedSet = require "OrderedSet"

local get_list = function(set)
  local l = {}
  for idx, item in set:pairs() do
    table.insert(l, item)
  end
  return l
end

subtest("test using letters", function()
  local s = OrderedSet.new({"a", "b", "c"})
  is_deeply(get_list(s), {"a", "b", "c",}, "initially created list")

  local reversed = {}
  for idx, item in s:pairs(true) do
    table.insert(reversed, item)
  end
  is_deeply(reversed, {"c", "b", "a"}, "got items via reverse iterator")

  s:insert("d");
  is_deeply(get_list(s), {"a", "b", "c", "d"}, "indirect insertion at tail")

  s:insert("e", 5);
  is_deeply(get_list(s), {"a", "b", "c", "d", "e"}, "direct insertion at tail")

  s:insert("pre-a", 1)
  is_deeply(get_list(s), {"pre-a", "a", "b", "c", "d", "e"}, "insertion at head")

  s:insert("b2", 3)
  is_deeply(get_list(s), {"pre-a", "a", "b2","b", "c", "d", "e"}, "insertion in middle")

  s:remove("b2")
  is_deeply(get_list(s), {"pre-a", "a", "b", "c", "d", "e"}, "removal from the middle")

  s:remove("e")
  is_deeply(get_list(s), {"pre-a", "a", "b", "c", "d"}, "removal tail")

  s:remove("pre-a")
  is_deeply(get_list(s), {"a", "b", "c", "d"}, "removal head")

  s:remove("a"); s:remove("b"); s:remove("c"); s:remove("d")
  is_deeply(get_list(s), {}, "emptying")

  s:insert("h");
  is_deeply(get_list(s), {"h"}, "still functional after empying")

  is(pcall(function() s:insert("h") end), false, "cannot insert duplicate element");
  is(pcall(function() s:insert("x", 5) end), false, "cannot insert with order greater than capacity");
  is(pcall(function() s:remove("xx") end), false, "cannot remove non-existing element");
end)

subtest("test using arbitrary elements", function()
  local f = function() end;
  local bool_t = true
  local bool_f = false
  local t = {}
  local s = OrderedSet.new({5, 3, 0, bool_t, bool_f, f, t})
  is_deeply(get_list(s), {5, 3, 0, bool_t, bool_f, f, t}, "creation")
  s:remove(true)
  is_deeply(get_list(s), {5, 3, 0, bool_f, f, t}, "boolean/true removal")
  s:remove(false)
  is_deeply(get_list(s), {5, 3, 0, f, t}, "boolean/false removal")
  s:remove(t)
  s:remove(5)
  s:remove(f)
  is_deeply(get_list(s), {3, 0}, "table, number, function removal")
end)

done_testing()
