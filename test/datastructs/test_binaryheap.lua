-- Desc: Unit tests for the BinaryHeap data structure

local BinaryHeap = require "datastructs.binaryheap"


print("BinaryHeap test start")

-- 测试各参数情况 compare, max_heap, allow_nil, allow_number, allow_duplicate

-- 测试数值最小堆，允许重复元素，不允许nil
local function test_num_min()
    local heap = BinaryHeap.new(nil, false, false, true, true)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 1)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 10)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 11)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 12)
    assert(heap:top() == 0)
end

-- 测试数值最大堆，允许重复元素，不允许nil
local function test_num_max()
    local heap = BinaryHeap.new(nil, true, false, true, true)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 8)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 10)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 11)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 12)
    assert(heap:top() == 9)
end

-- 测试数值最小堆，不允许重复元素，不允许nil
local function test_num_min_no_duplicate()
    local heap = BinaryHeap.new(nil, false, false, true, false)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 1)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)
end

-- 测试数值最大堆，不允许重复元素，不允许nil
local function test_num_max_no_duplicate()
    local heap = BinaryHeap.new(nil, true, false, true, false)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 8)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)
end

-- 测试数值最小堆，允许重复元素，允许nil
local function test_num_min_allow_nil()
    local compare = function(a, b)
        if a == nil then
            return true
        elseif b == nil then
            return false
        else
            return a < b
        end
    end

    local heap = BinaryHeap.new(compare, false, false, true, true)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 1)

    heap:insert(0)
    assert(heap:size() == 9)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 10)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 11)
    assert(heap:top() == 0)

    heap:insert(0)
    assert(heap:size() == 12)
    assert(heap:top() == 0)

    heap:insert(nil)
    assert(heap:size() == 13)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 14)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 15)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 16)
    assert(heap:top() == nil)
end

-- 测试数值最大堆，允许重复元素，允许nil
local function test_num_max_allow_nil()
    local compare = function(a, b)
        if a == nil then
            return true
        elseif b == nil then
            return false
        else
            return a > b
        end
    end

    local heap = BinaryHeap.new(compare, true, false, true, true)
    heap:insert(1)
    heap:insert(2)
    heap:insert(3)
    heap:insert(4)
    heap:insert(5)
    heap:insert(6)
    heap:insert(7)
    heap:insert(8)

    assert(heap:size() == 8)
    assert(heap:top() == 8)

    heap:insert(9)
    assert(heap:size() == 9)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 10)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 11)
    assert(heap:top() == 9)

    heap:insert(9)
    assert(heap:size() == 12)
    assert(heap:top() == 9)

    heap:insert(nil)
    assert(heap:size() == 13)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 14)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 15)
    assert(heap:top() == nil)

    heap:insert(nil)
    assert(heap:size() == 16)
    assert(heap:top() == nil)
end

-- 测试table最小堆，允许重复元素，不允许nil
local function test_table_min_allow_duplicate()
    local compare = function(a, b)
        return a.value < b.value
    end

    local heap = BinaryHeap.new(compare, false, false, false, false)
    heap:insert({value = 1})
    heap:insert({value = 2})
    heap:insert({value = 3})
    heap:insert({value = 4})
    heap:insert({value = 5})
    heap:insert({value = 6})
    heap:insert({value = 7})
    heap:insert({value = 8})

    assert(heap:size() == 8)
    assert(heap:top().value == 1)

    heap:insert({value = 0})
    assert(heap:size() == 9)
    assert(heap:top().value == 0)

    heap:insert({value = 0})
    assert(heap:size() == 10)
    assert(heap:top().value == 0)

    heap:insert({value = 0})
    assert(heap:size() == 11)
    assert(heap:top().value == 0)

    heap:insert({value = 0})
    assert(heap:size() == 12)
    assert(heap:top().value == 0)
end

-- 测试table最大堆，允许重复元素，不允许nil
local function test_table_max_allow_duplicate()
    local compare = function(a, b)
        return a.value > b.value
    end

    local heap = BinaryHeap.new(compare, true, false, false, false)
    heap:insert({value = 1})
    heap:insert({value = 2})
    heap:insert({value = 3})
    heap:insert({value = 4})
    heap:insert({value = 5})
    heap:insert({value = 6})
    heap:insert({value = 7})
    heap:insert({value = 8})

    assert(heap:size() == 8)
    assert(heap:top().value == 8)

    heap:insert({value = 9})
    assert(heap:size() == 9)
    assert(heap:top().value == 9)

    heap:insert({value = 9})
    assert(heap:size() == 10)
    assert(heap:top().value == 9)

    heap:insert({value = 9})
    assert(heap:size() == 11)
    assert(heap:top().value == 9)

    heap:insert({value = 9})
    assert(heap:size() == 12)
    assert(heap:top().value == 9)
end

-- 测试string最小堆，允许重复元素，不允许nil
local function test_string_min_allow_duplicate()
    local compare = function(a, b)
        return a < b
    end

    local heap = BinaryHeap.new(compare, false, false, false, false)
    heap:insert("1")
    heap:insert("2")
    heap:insert("3")
    heap:insert("4")
    heap:insert("5")
    heap:insert("6")
    heap:insert("7")
    heap:insert("8")

    assert(heap:size() == 8)
    assert(heap:top() == "1", heap:top())

    heap:insert("0")
    assert(heap:size() == 9)
    assert(heap:top() == "0")

    heap:insert("0")
    assert(heap:size() == 10)
    assert(heap:top() == "0")

    heap:insert("0")
    assert(heap:size() == 11)
    assert(heap:top() == "0")

    heap:insert("0")
    assert(heap:size() == 12)
    assert(heap:top() == "0")
end

test_num_min()
test_num_max()
test_table_min_allow_duplicate()
test_table_max_allow_duplicate()
test_string_min_allow_duplicate()

print("test ok")


