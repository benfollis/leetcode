# @param {String[]} transactions
# @return {String[]}
def invalid_transactions(transactions)
  transactions_by_name = transactions.reduce({}) do |acc, tx_string|
    tx = tx_string.split(",")
    name, time, amount, location = tx
    tx_list = acc[name] || []
    tx_list << [name, time.to_i, amount.to_i, location]
    acc[name] = tx_list
    acc
  end
  all_suspicious = transactions_by_name.keys.reduce([]) do |acc, name|
    name_suspicious = process_persons_tx(transactions_by_name[name])
    acc + name_suspicious
  end
  all_suspicious
end


def process_persons_tx(tx_list)
  suspicious = []
  #sort by time
  #this search is o(n^2) in the size of the tx tx_list
  # you'd need something like a range tree to cut that down
  tx_list.each do |tx|
    # puts "Previous TX: #{previous.inspect}"
    #puts "TX: #{tx.inspect}"
    _, time, amount, location = tx
    # the amount test. However we can't just go to the next one, because this
    # may force the previous to be suspicious as well. Techincally we
    # can add it twice, but the uniq test will take care of it
    # if run time is a problem we could use a set to handle unique
    if amount > 1000 then
      suspicious << tx
    else
      colliding_different_loc = tx_list.select { |x| (time - x[1]).abs <= 60 && (location != x[3])}
      if (colliding_different_loc.size > 0) then
        suspicious << tx
      end
    end
  end
  suspicious.sort_by { |x| x[1] }.map { |tx| tx.join(",") }
end

#test = ["alice,20,800,mtv","alice,50,100,beijing"]
#test = ["bob,689,1910,barcelona","alex,696,122,bangkok","bob,832,1726,barcelona","bob,820,596,bangkok","chalicefy,217,669,barcelona","bob,175,221,amsterdam"]
#test = ["lee,886,1785,beijing","alex,763,1157,amsterdam","lee,277,129,amsterdam","bob,770,105,amsterdam","lee,603,926,amsterdam","chalicefy,476,50,budapest","lee,924,859,barcelona","alex,302,590,amsterdam","alex,397,1464,barcelona","bob,412,1404,amsterdam","lee,505,849,budapest"]
test = ["bob,649,842,prague", "alex,175,1127,mexico", "iris,164,119,paris", "lee,991,1570,mexico", "lee,895,1876,taipei", "iris,716,754,moscow", "chalicefy,19,592,singapore", "chalicefy,820,71,newdelhi", "maybe,231,1790,paris", "lee,158,987,mexico", "chalicefy,415,22,montreal", "iris,803,691,milan", "xnova,786,804,guangzhou", "lee,734,1915,prague", "bob,836,1904,dubai", "iris,666,231,chicago", "iris,677,1451,milan", "maybe,860,517,toronto", "iris,344,1452,bangkok", "lee,664,463,frankfurt", "chalicefy,95,1222,montreal", "lee,293,1102,istanbul", "maybe,874,36,hongkong", "maybe,457,1802,montreal", "xnova,535,270,munich", "iris,39,264,istanbul", "chalicefy,548,363,barcelona", "lee,373,184,munich", "xnova,405,957,mexico", "chalicefy,517,266,luxembourg", "iris,25,657,singapore", "bob,688,451,beijing", "bob,263,1258,tokyo", "maybe,140,222,amsterdam", "xnova,852,330,barcelona", "xnova,589,837,budapest", "lee,152,981,mexico", "alex,893,1976,shenzhen", "xnova,560,825,prague", "chalicefy,283,399,zurich", "iris,967,1119,guangzhou", "alex,924,223,milan", "chalicefy,212,1865,chicago", "alex,443,537,taipei", "maybe,390,5,shanghai", "bob,510,1923,madrid", "bob,798,343,hongkong", "iris,643,1703,madrid", "bob,478,928,barcelona", "maybe,75,1980,shanghai", "xnova,293,24,newdelhi", "iris,176,268,milan", "alex,783,81,moscow", "maybe,560,587,milan", "alex,406,776,istanbul", "lee,558,727,paris", "maybe,481,1504,munich", "maybe,685,602,madrid", "iris,678,788,madrid", "xnova,704,274,newdelhi", "chalicefy,36,1984,paris", "iris,749,200,amsterdam", "lee,21,119,taipei", "iris,406,433,bangkok", "bob,777,542,taipei", "maybe,230,1434,barcelona", "iris,420,1818,zurich", "lee,622,194,amsterdam", "maybe,545,608,shanghai", "xnova,201,1375,madrid", "lee,432,520,dubai", "bob,150,1634,singapore", "maybe,467,1178,munich", "iris,45,904,beijing", "maybe,607,1953,tokyo", "bob,901,815,tokyo", "maybe,636,558,milan", "bob,568,1674,toronto", "iris,825,484,madrid", "iris,951,930,dubai", "bob,465,1080,taipei", "bob,337,593,chicago", "chalicefy,16,176,rome", "chalicefy,671,583,singapore", "iris,268,391,chicago", "xnova,836,153,jakarta", "bob,436,530,warsaw", "alex,354,1328,luxembourg", "iris,928,1565,paris", "xnova,627,834,budapest", "xnova,640,513,jakarta", "alex,119,16,toronto", "xnova,443,1687,taipei", "chalicefy,867,1520,montreal", "alex,456,889,newdelhi", "lee,166,3,madrid", "bob,65,1559,zurich", "alex,628,861,moscow", "maybe,668,572,mexico", "bob,402,922,montreal"]
expected = ["bob,649,842,prague", "alex,175,1127,mexico", "iris,164,119,paris", "lee,991,1570,mexico", "lee,895,1876,taipei", "iris,716,754,moscow", "chalicefy,19,592,singapore", "chalicefy,820,71,newdelhi", "maybe,231,1790,paris", "lee,158,987,mexico", "iris,803,691,milan", "xnova,786,804,guangzhou", "lee,734,1915,prague", "bob,836,1904,dubai", "iris,666,231,chicago", "iris,677,1451,milan", "maybe,860,517,toronto", "iris,344,1452,bangkok", "lee,664,463,frankfurt", "chalicefy,95,1222,montreal", "lee,293,1102,istanbul", "maybe,874,36,hongkong", "maybe,457,1802,montreal", "xnova,535,270,munich", "iris,39,264,istanbul", "chalicefy,548,363,barcelona", "lee,373,184,munich", "xnova,405,957,mexico", "chalicefy,517,266,luxembourg", "iris,25,657,singapore", "bob,688,451,beijing", "bob,263,1258,tokyo", "xnova,852,330,barcelona", "xnova,589,837,budapest", "lee,152,981,mexico", "alex,893,1976,shenzhen", "xnova,560,825,prague", "iris,967,1119,guangzhou", "alex,924,223,milan", "chalicefy,212,1865,chicago", "alex,443,537,taipei", "bob,510,1923,madrid", "bob,798,343,hongkong", "iris,643,1703,madrid", "bob,478,928,barcelona", "maybe,75,1980,shanghai", "iris,176,268,milan", "maybe,560,587,milan", "alex,406,776,istanbul", "maybe,481,1504,munich", "maybe,685,602,madrid", "iris,678,788,madrid", "chalicefy,36,1984,paris", "iris,749,200,amsterdam", "iris,406,433,bangkok", "bob,777,542,taipei", "maybe,230,1434,barcelona", "iris,420,1818,zurich", "lee,622,194,amsterdam", "maybe,545,608,shanghai", "xnova,201,1375,madrid", "lee,432,520,dubai", "bob,150,1634,singapore", "maybe,467,1178,munich", "iris,45,904,beijing", "maybe,607,1953,tokyo", "maybe,636,558,milan", "bob,568,1674,toronto", "iris,825,484,madrid", "iris,951,930,dubai", "bob,465,1080,taipei", "chalicefy,16,176,rome", "xnova,836,153,jakarta", "bob,436,530,warsaw", "alex,354,1328,luxembourg", "iris,928,1565,paris", "xnova,627,834,budapest", "xnova,640,513,jakarta", "alex,119,16,toronto", "xnova,443,1687,taipei", "chalicefy,867,1520,montreal", "alex,456,889,newdelhi", "lee,166,3,madrid", "bob,65,1559,zurich", "maybe,668,572,mexico", "bob,402,922,montreal"]
result = invalid_transactions(test)
sorted_result = result.sort
sorted_expected = expected.sort
if sorted_result == sorted_expected then
  puts "All match"
else
  puts "Result"
  puts sorted_result.inspect
  puts "Expected"
  puts sorted_expected.inspect
end