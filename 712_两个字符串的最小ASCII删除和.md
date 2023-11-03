## 题目

[712. 两个字符串的最小ASCII删除和](https://leetcode.cn/problems/minimum-ascii-delete-sum-for-two-strings/)

给定两个字符串`s1` 和 `s2`，返回 *使两个字符串相等所需删除字符的 **ASCII** 值的最小和* 。

 

**示例 1:**

```
输入: s1 = "sea", s2 = "eat"
输出: 231
解释: 在 "sea" 中删除 "s" 并将 "s" 的值(115)加入总和。
在 "eat" 中删除 "t" 并将 116 加入总和。
结束时，两个字符串相等，115 + 116 = 231 就是符合条件的最小和。
```

**示例 2:**

```
输入: s1 = "delete", s2 = "leet"
输出: 403
解释: 在 "delete" 中删除 "dee" 字符串变成 "let"，
将 100[d]+101[e]+101[e] 加入总和。在 "leet" 中删除 "e" 将 101[e] 加入总和。
结束时，两个字符串都等于 "let"，结果即为 100+101+101+101 = 403 。
如果改为将两个字符串转换为 "lee" 或 "eet"，我们会得到 433 或 417 的结果，比答案更大。
```

 

**提示:**

- `0 <= s1.length, s2.length <= 1000`
- `s1` 和 `s2` 由小写英文字母组成

## 代码

```java
class Solution {
    public int minimumDeleteSum(String s1, String s2) {
        char[] a = s1.toCharArray();
        char[] b = s2.toCharArray();
        int[][] dp = new int[a.length + 1][b.length + 1];
        // dp[i][j]表示前i个字符
        for (int i = 1; i <= a.length; i++) dp[i][0] = a[i - 1] + dp[i - 1][0];
        for (int j = 1; j <= b.length; j++) dp[0][j] = b[j - 1] + dp[0][j - 1];
        dp[0][0] = 0;
        for (int i = 1; i <= a.length; i++) {
            for (int j = 1; j <= b.length; j++) {
                if (a[i - 1] == b[j - 1]) {
                    // 不需要删除
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    // 选择 1. 全部删除 2. 删除a[i-1] 3. 删除b[j-1]
                    dp[i][j] = Math.min(dp[i - 1][j - 1] + a[i - 1] + b[j - 1],
                            Math.min(dp[i][j - 1] + b[j - 1] , dp[i - 1][j] +a[i - 1]));
                }
            }
        }
        return dp[a.length][b.length];
    }
}
```

## 思路

本题与  `[72. 编辑距离](https://leetcode.cn/problems/edit-distance/)` 非常类似(其实就是一样)

> [72. 编辑距离](https://leetcode.cn/problems/edit-distance/)
>
> 给你两个单词 `word1` 和 `word2`， *请返回将 `word1` 转换成 `word2` 所使用的最少操作数* 。
>
> 你可以对一个单词进行如下三种操作：
>
> - 插入一个字符
> - 删除一个字符
> - 替换一个字符

一个是统计次数 , 一个是统计最小的ASCII值

本题 的DP数组是非常容易想到的

`dp[i][j]`表示前i , j个字符  变成相同需要删除的最小的ASCII的值

对于第一行和第一列,  每一个都需要删除(并且是累加的)  ,对于 0,0 则是不需要删除任何字符

```java
for (int i = 1; i <= a.length; i++) dp[i][0] = a[i - 1] + dp[i - 1][0];
for (int j = 1; j <= b.length; j++) dp[0][j] = b[j - 1] + dp[0][j - 1];
dp[0][0] = 0;
```

接着我们来思考 状态转移方程

分成两种情况

- 当前两个字符相同 : 不需要删除任何字符 , 沿用前一种的状态`dp[i][j] = dp[i - 1][j - 1];`

- 不同: 需要中前面的几种状态中 选取一个(ASCII最小的)  , 此时我们有三种选择

  1. **当前的两个字符 全部删除**
  2. 删除a[i-1]
  3. 删除b[j-1]

  那么对应的表达式就是

  ` dp[i][j] = Math.min(dp[i - 1][j - 1] + a[i - 1] + b[j - 1], Math.min(dp[i][j - 1] + b[j - 1] , dp[i - 1][j] +a[i - 1]));`

最后我们返回 最终的字符串的 DP结果即可