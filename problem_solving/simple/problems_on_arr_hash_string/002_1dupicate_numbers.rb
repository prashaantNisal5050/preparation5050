require 'byebug'
def remove_duplicates(nums)
    k = 0
    nums.each do |num|
      byebug
      if k == 0 || num != nums[k - 1]
        nums[k] = num
        k += 1
      end
    end
    return k, nums[0...k]
  end
sorted_array = [1, 2, 3, 4, 5, 1, 2, 6, 7].sort
p remove_duplicates(sorted_array)

=begin
# iterations
| Step | Current `num` | `nums[k - 1]` | Action           | Resulting Array | `k` |
| ---- | ------------- | ------------- | ---------------- | --------------- | --- |
| 1    | 1             | —             | Add (k==0)       | \[1]            | 1   |
| 2    | 1             | 1             | Skip (duplicate) | \[1]            | 1   |
| 3    | 2             | 1             | Add              | \[1,2]          | 2   |
| 4    | 2             | 2             | Skip             | \[1,2]          | 2   |
| 5    | 3             | 2             | Add              | \[1,2,3]        | 3   |
| ...  | ...           | ...           | ...              | ...             | ... |

Time Complexity: O(n)
You traverse the array once → linear time

✅ Space Complexity: O(1)
You modify the array in-place

No extra space is used (besides a few variables)

# Scenario

| Scenario       | Approach Used           | Time | Space | Optimal?            |
| -------------- | ----------------------- | ---- | ----- | ------------------- |
| Sorted Array   | Two-pointer (your code) | O(n) | O(1)  | ✅ Yes               |
| Unsorted Array | HashSet/Set             | O(n) | O(n)  | ✅ Yes for that case |

=end

