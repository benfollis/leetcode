# idea, bucketize people into heights, then sort
# the buckets by the number of people in front of them
# start processing the largestheight person first, and in order of people in front
# and their position in the queue should be the number of people in front of them
# (the same for the next person in the smallest bucket, etc)
# The loop invariant is that at every iteration the queue contains exactly
# the number of people taller than you that your queue positions says should be there
# @param {Integer[][]} people
# @return {Integer[][]}
def reconstruct_queue(people)
  buckets = people.reduce({}) do |acc, person|
    height = person[0]
    bucket_contents = acc[height] || []
    bucket_contents << person
    acc[height] = bucket_contents
    acc
  end
  # puts buckets.inspect
  queue = []
  # start processing from the smallest heights
  buckets.keys.sort.reverse.each do |height|
    bucket = buckets[height]
    sorted_bucket = bucket.sort
    sorted_bucket.each do |person|
      _, people_in_front = person
      queue.insert(people_in_front, person)
    end
  end
  queue
end

input = [[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]
puts reconstruct_queue(input).inspect
