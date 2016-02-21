# lua-ordered-set
Ordered set implementation in lua

1. It is not allowed to add duplicate into set
2. Adding element to **head** or **tail** is `O(1)` fast 
3. Adding element in **middle** of set is `O(N)` slow, discouraged
4. Removing element from anywhere is `O(1)` fast
