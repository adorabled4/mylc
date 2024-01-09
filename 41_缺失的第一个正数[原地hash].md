## 题目

[41. 缺失的第一个正数](https://leetcode.cn/problems/first-missing-positive/)

给你一个未排序的整数数组 `nums` ，请你找出其中没有出现的最小的正整数。

请你实现时间复杂度为 `O(n)` 并且只使用常数级别额外空间的解决方案。

**示例 1：**

```
输入：nums = [1,2,0]
输出：3
```

**示例 2：**

```
输入：nums = [3,4,-1,1]
输出：2
```

**示例 3：**

```
输入：nums = [7,8,9,11,12]
输出：1
```

**提示：**

- `1 <= nums.length <= 5 * 105`
- `-231 <= nums[i] <= 231 - 1`

## 代码

```java
class Solution {
    public int firstMissingPositive(int[] nums) {
        // 我们原地交换元素, 把每个元素调整到对应的位置
        // index:val , 0:1 ,1:2
        int n=nums.length;
        // 对于 val 在 1~n 范围的, 我们吧元素调整到对应的位置
        for(int i=0;i<n;i++){
            while(nums[i]>0 && nums[i]<=n && nums[nums[i]-1] != nums[i]){
                swap(nums,nums[i]-1,i);
            }
        }
        // 后续进行遍历, 如果当前的元素不是顺序的 (比如1 3 3)不是顺序的, 
        // 那么此时最小的正数就是2 (idx+1)
        for(int i=0;i<n;i++){
            if(nums[i]!=i+1){
                return i+1;
            }
        }
        return n+1;
    }

    private void swap(int[]nums,int i,int j ){
        int tmp = nums[i];
        nums[i]=nums[j];
        nums[j]=tmp;
    }
}
```

## 思路

本题的核心思路在于

**让对应位置的元素归位**

> 参考题目 `https://leetcode.cn/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof/`

比如 元素 2 , 我们把 2 放到数组中的第二个位置(索引为 1 )

此时判断的方式是 

```java
int cur = nums[i];
if(nums[cur-1]!=cur){
	swap(nums,cur-1,i);
}

private void swap(int[]nums, int i,int j){
    int tmp=nums[i];
    nums[i]=nums[j];
    nums[j]=tmp;
}
```

但是需要注意的是 , 并不是**一次交换**就可以 **调整好的**

比如 `[3,4,2,1,1,0]`

我们需要做的

1. 把3 调整到 nums[2]
2. 把1 调整到 nums[0]

因此这里需要通过while来进行 , 否则会导致 元素 3 调整好了, 但是对应的1 却没有调整好

下面的测试的代码

```java
static class Solution {
    public int findRepeatDocument(int[] nums) {
        int i = 0;
        System.out.println("[%d]初始数组: ".formatted(i) + Arrays.toString(nums));
        while(i < nums.length) {
            if(nums[i] == i) {
                System.out.println("[%d]符合跳过: ".formatted(i) + Arrays.toString(nums));
                i++;
                continue;
            }
            if(nums[nums[i]] == nums[i]){
                System.out.println("[%d]重合返回: ".formatted(i) + Arrays.toString(nums));
                return nums[i];
            }
            int tmp = nums[i];
            nums[i] = nums[tmp];
            nums[tmp] = tmp;
            System.out.println("[%d]执行交换: ".formatted(i) + Arrays.toString(nums));
        }
        return -1;
    }
}
public static void main(String[] args) {
    new Solution().findRepeatDocument(new int[]{3,4,2,1,1,0});
}
```

打印结果如下 : 

```'
[0]初始数组: [3, 4, 2, 1, 1, 0]
[0]执行交换: [1, 4, 2, 3, 1, 0]
[0]执行交换: [4, 1, 2, 3, 1, 0]
[0]执行交换: [1, 1, 2, 3, 4, 0]
[0]重合返回: [1, 1, 2, 3, 4, 0]
```

可以看到, 指针始终都是指向 0 

----

对于元素超出N的范围, 这里是不需要考虑的, 如果所有的元素都超出了范围 , 那么最后的最小正数就是1

> 考虑**尽量小的数字**, 因此超出N是不需要考虑的

反之所有的数字都是 N 之内, 那么最小的数字就是 **最大的数字 +1** 