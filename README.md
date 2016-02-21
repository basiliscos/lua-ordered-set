# lua-ordered-set
Ordered set implementation in lua

[![Build Status](https://travis-ci.org/basiliscos/lua-ordered-set.png)](https://travis-ci.org/basiliscos/lua-ordered-set)


1. It is not allowed to add duplicate into set
2. The order of element is pre-served
2. Adding element to **head** or **tail** is `O(1)` fast 
3. Adding element in **middle** of set is `O(N)` slow, discouraged
4. Removing element from anywhere is `O(1)` fast
5. Anything could be element, except `nil`


# Example
```lua
local OrderedSet = require "OrderedSet"
local set = OrderedSet.new({"a", "b", "c"})

set:insert("d")
set:insert("bb", 2) -- slow
set:remove("a")

for index, element in set:pairs() do
  print(index .. ": " .. element)
end

```

Installation
============

```luarocks install OrderedScope```


# License

Artistic License 2.0
