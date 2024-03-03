## 题目

[208. 实现 Trie (前缀树)](https://leetcode.cn/problems/implement-trie-prefix-tree/)

**[Trie](https://baike.baidu.com/item/字典树/9825209?fr=aladdin)**（发音类似 "try"）或者说 **前缀树** 是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。

请你实现 Trie 类：

- `Trie()` 初始化前缀树对象。
- `void insert(String word)` 向前缀树中插入字符串 `word` 。
- `boolean search(String word)` 如果字符串 `word` 在前缀树中，返回 `true`（即，在检索之前已经插入）；否则，返回 `false` 。
- `boolean startsWith(String prefix)` 如果之前已经插入的字符串 `word` 的前缀之一为 `prefix` ，返回 `true` ；否则，返回 `false` 。

**示例：**

```
输入
["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
[[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
输出
[null, null, true, false, true, null, true]

解释
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // 返回 True
trie.search("app");     // 返回 False
trie.startsWith("app"); // 返回 True
trie.insert("app");
trie.search("app");     // 返回 True
```

 

**提示：**

- `1 <= word.length, prefix.length <= 2000`
- `word` 和 `prefix` 仅由小写英文字母组成
- `insert`、`search` 和 `startsWith` 调用次数 **总计** 不超过 `3 * 104` 次

## 代码

```GO
type Trie struct {
	child [26]*Trie
    isEnd bool
}


func Constructor() Trie {
    return Trie{}
}


func (this *Trie) Insert(word string)  {
    t:=this
    for _,ch:=range word{
        ch-='a'
        if t.child[ch] == nil {
            t.child[ch] = &Trie{}
        }
        t= t.child[ch]
    }
    t.isEnd = true
}


func (this *Trie) Search(word string) bool {
    t:=this.SearchPrefix(word)
    return t!=nil && t.isEnd 
}


func (this *Trie)SearchPrefix(word string) *Trie {
    t:=this
    for _,ch:=range word{
        ch-='a'
        if t.child[ch] == nil {
            return nil
        }
        t= t.child[ch]
    }
    return t
}


func (this *Trie) StartsWith(prefix string) bool {
    return this.SearchPrefix(prefix)!=nil
}

```

## 思路

这里题目的要求的范围是 26 个小写字母, 因此我们可以构建一个Trie的数据结构

其中包含了:

1. child : [26]*Trie , 对应的26个字母的子树, 如果为空说明不存在
2. isEnd : bool , 标记当前是否是结束节点 , 例如存储了 apple, app , 那么在第三层的app的节点时候会存储一个isEnd

每次往下一层, 对应着

word指针右移,  Trie树向下层遍历.

对于的操作: 

插入, 构建下一层的 Trie树: 

这样随着字符串的遍历, 我们逐层的构建 Trie树

```go
func (t * Trie) insert(word String) {
    cur:=t
    for _,c:=range word{
        c-='a'
        if cur.child[c]==nil{
            cur.child = &Trie{}
        }
        cur = cur.child[c]
    }
}
```

对于查找操作, 可以首先抽象出一个是否以某字符串为前缀的func

```go
func (t*Trie) searchPrefix(word string) *Trie{
    cur:=t
    for _,c:=range word{
        c-='a'
        if cur.child[c] == nil {
            return nil
        }
        cur = cur.child[c]
    }
    return cur
}
```

这样的话, 对于题目要求的Search 以及 StartsWith 方法, 我们都可以快速的实现

```go
func (t*Trie) Search(word string) *Trie{
    cur:=t.searchPrefix(word)
    return cur!=nil && cur.isEnd
}
```

StartsWith就更加简单: 

```go
func (t*Trie)StartsWith(word String) *Trie{
    return t.searchPrefix(word) != nil
}
```





