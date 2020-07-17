object Solution {
  def runningSum(nums: Array[Int]): Array[Int] = {
    var total = 0
    val running_sum = nums.map(x => {
      total = total + x
      total
    })
    running_sum
  }
}