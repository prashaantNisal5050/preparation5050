require 'set'
require 'byebug'
def find_duplicates(nums)
  seen = Set.new    # Initialize an empty set to store unique elements
  duplicates = []    # Initialize an array to store duplicates

  nums.each do |num|
    if seen.include?(num)  # If the number is already in the set, it's a duplicate
      duplicates << num
    else
      seen.add(num)  # Otherwise, add the number to the set
    end
  end
  {
    duplicates: duplicates,
    unique: seen.to_a
  }  # Return the list of duplicates
end

# Example usage:

nums = [1, 2, 3, 4, 5, 1, 2, 6, 7]
puts find_duplicates(nums)# .inspect  # Output: [1, 2]
