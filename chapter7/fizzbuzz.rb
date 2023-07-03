def fizzbuzz
  n = 1
  while n <= 100
    if n % 15 == 0
      p "FizzBuzz"
    elsif n % 3 == 0
      p "Fizz"
    elsif n % 5 == 0
      p "Buzz"
    end
    n = n + 1
  end
end