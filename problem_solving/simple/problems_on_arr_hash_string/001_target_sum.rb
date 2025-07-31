require 'byebug'
# A brute force solution would involve checking every pair of numbers in the array to see if their sum equals the target. 
# complexity:  O(n²)
# Explanation:
# The outer loop iterates through each number.
# The inner loop starts from the next number after the current one in the outer loop and checks if their sum equals the target.
# If a pair is found, it returns their indices.
# If no pair is found after all iterations, it returns nil.


# below approch is more optimized
# Use a hash to achieve  O(n) time complexity.
def target_sum(nums, target)
  hash = {}
  nums.each_with_index do |num, idx|
    difference = target - num
    return [hash[difference], idx] if hash.key?(difference)
    hash[num] = idx
  end
  nil
end

puts target_sum([2, 11,15, 7],9).inspect # Output: [0, 1]

