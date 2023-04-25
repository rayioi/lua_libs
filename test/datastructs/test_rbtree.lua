local RBTree = require "datastructs.rbtree"

print("RBTree test start")

-- 测试插入, 校验节点颜色和值
local function test_insert()
    local tree = RBTree.new()
    tree:insert(1, 1)
    tree:insert(2, 2)
    tree:insert(3, 3)
    tree:insert(4, 4)
    tree:insert(5, 5)
    tree:insert(6, 6)
    tree:insert(7, 7)
    tree:insert(8, 8)
    tree:insert(9, 9) 

    tree:print()

    assert(tree:size() == 9)

    local node = tree:find(1)
    assert(node.color == RBTree.BLACK)
    assert(node.value == 1)

    node = tree:find(2)
    assert(node.color == RBTree.RED)
    assert(node.value == 2)

    node = tree:find(3)
    assert(node.color == RBTree.BLACK)
    assert(node.value == 3)

    node = tree:find(4)
    assert(node.color == RBTree.BLACK)
    assert(node.value == 4)

    node = tree:find(5)
    assert(node.color == RBTree.BLACK)
    assert(node.value == 5)

    node = tree:find(6)
    assert(node.color == RBTree.RED)
    assert(node.value == 6)

    node = tree:find(7)
    assert(node.color == RBTree.RED)
    assert(node.value == 7)

    node = tree:find(8)
    assert(node.color == RBTree.BLACK)
    assert(node.value == 8)

    node = tree:find(9)
    assert(node.color == RBTree.RED)
    assert(node.value == 9)
end

-- 测试删除节点
local function test_delete()
    local tree = RBTree.new()
    tree:insert(1, 1)
    tree:insert(2, 2)
    tree:insert(3, 3)
    tree:insert(4, 4)
    tree:insert(5, 5)
    tree:insert(6, 6)
    tree:insert(7, 7)
    tree:insert(8, 8)
    tree:insert(9, 9) 

    tree:print()

    tree:delete(1)
    tree:print()

    tree:delete(2)
    tree:print()

    tree:delete(3)
    tree:print()

    tree:delete(4)
    tree:print()

    tree:delete(5)
    tree:print()

    tree:delete(6)
    tree:print()

    tree:delete(7)
    tree:print()

    tree:delete(8)
    tree:print()

    tree:delete(9)
    tree:print()
end

test_insert()
test_delete()


print("RBTree test end")
