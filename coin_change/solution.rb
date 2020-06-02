# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
  sorted_coins = coins.sort
  r = Array.new(amount+1)
  r[0] = 0
  sorted_coins.each do |coin|
    (1..amount).each do |amount|
      without_coin_index = amount - coin
      if (without_coin_index >= 0 && !r[without_coin_index].nil?) then
        using_this_coin = r[without_coin_index] + 1
        if r[amount].nil?
          r[amount] = using_this_coin
        else
          r[amount] = [using_this_coin, r[amount]].min
        end
      end
    end
  end
  return -1 if r[amount].nil?
  return r[amount]
end



coins = [2]
amount = 11
result = coin_change(coins, amount)
puts result