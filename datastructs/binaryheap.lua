--[[
    -- 实现二叉堆
        -- 支持配置比较函数
        -- 支持配置最大堆或最小堆
        -- 支持配置是否允许重复元素
        -- 支持配置是否允许插入nil
        -- 支持配置是否允许插入非数字类型
]]

local tinsert = table.insert
local tremove = table.remove
local mfloor = math.floor

-- 定义二叉堆类
local BinaryHeap = {}
BinaryHeap.__index = BinaryHeap

-- 交换堆中的两个元素
function BinaryHeap:swap(i, j)
    self.heap[i], self.heap[j] = self.heap[j], self.heap[i]
end

-- 获取父节点的索引
function BinaryHeap:parent(i)
    return mfloor(i / 2)
end

-- 获取左子节点的索引
function BinaryHeap:left(i)
    return 2 * i
end

-- 获取右子节点的索引
function BinaryHeap:right(i)
    return 2 * i + 1
end

-- 向上调整堆
function BinaryHeap:heapify_up(i)
    local p = self:parent(i)
    if p > 0 and self.compare(self.heap[i], self.heap[p]) then
        self:swap(i, p)
        self:heapify_up(p)
    end
end

-- 向下调整堆
function BinaryHeap:heapify_down(i)
    local l = self:left(i)
    local r = self:right(i)
    local smallest = i

    if l <= #self.heap and self.compare(self.heap[l], self.heap[smallest]) then
        smallest = l
    end

    if r <= #self.heap and self.compare(self.heap[r], self.heap[smallest]) then
        smallest = r
    end

    if smallest ~= i then
        self:swap(i, smallest)
        self:heapify_down(smallest)
    end
end

-- 插入元素
function BinaryHeap:insert(value)
    if not self.allow_nil and value == nil then
        error("nil is not allowed")
    end

    if self.allow_number and type(value) ~= "number" then
        error("only number is allowed")
    end

    tinsert(self.heap, value)
    self:heapify_up(#self.heap)
end

-- 删除元素
function BinaryHeap:delete(value)
    local index = self:find(value)
    if index then
        self:swap(index, #self.heap)
        tremove(self.heap, #self.heap)
        self:heapify_down(index)
    end
end

-- 查找元素
function BinaryHeap:find(value)
    for i, v in ipairs(self.heap) do
        if v == value then
            return i
        end
    end
end

-- 获取堆顶元素
function BinaryHeap:top()
    return self.heap[1]
end

-- 删除堆顶元素
function BinaryHeap:pop()
    if #self.heap < 1 then
        error("Heap underflow")
    end

    local top = self.heap[1]
    self:swap(1, #self.heap)
    tremove(self.heap, #self.heap)
    self:heapify_down(1)

    return top
end

-- 获取堆中元素的数量
function BinaryHeap:size()
    return #self.heap
end

-- 创建一个新的二叉堆
function BinaryHeap.new(compare, max_heap, allow_nil, allow_number, allow_duplicate)
    local obj = {
        heap = {},
        compare = compare,
        allow_nil = allow_nil,
        allow_number = allow_number,
        allow_duplicate = allow_duplicate,
    }

    if allow_number == nil then
        obj.allow_number = true
    end

    if allow_nil == nil then
        obj.allow_nil = false
    end

    if allow_duplicate == nil then
        obj.allow_duplicate = true
    end

    if max_heap == nil then
        max_heap = false
    end

    if not obj.compare then
        if not obj.allow_number then
            error("compare function is required")
        end

        if not obj.allow_duplicate then
            error("compare function is required")
        end

        if obj.allow_nil then
            error("compare function is required")
        end

        if max_heap then
            obj.compare = function(a, b)
                return a > b
            end
        else
            obj.compare = function(a, b)
                return a < b
            end
        end
    end

    return setmetatable(obj, BinaryHeap)
end

return BinaryHeap