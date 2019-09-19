defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do    
    splitArray = String.split(expr,~r/\s+/)
    if length(splitArray) == 1 do
	parse_float(expr)
    else
	[operand1 | rest] = splitArray
    	# evaluateExpr(operand1, rest)
        multDivAns = evaluateMultDiv(splitArray,0)
        evaluateAddSub(multDivAns,0)
    end
  end

  def evaluateMultDiv(expr,index) do
    if length(expr) == 1 do
      Enum.at(expr,0)
    else
      if (Enum.at(expr,index + 1) == "*") || (Enum.at(expr,index + 1) == "/") do
	 ans = cond do
	   Enum.at(expr,index + 1) == "*" ->
	     parse_float(Enum.at(expr,index)) * parse_float(Enum.at(expr,index + 2))
	   Enum.at(expr,index + 1) == "/" ->
	     parse_float(Enum.at(expr,index)) / parse_float(Enum.at(expr,index + 2))
	 end
	 if index == length(expr) - 3 do
	   Enum.take(expr,index) ++ [Float.to_string(ans)]
	 else
	   newArray = Enum.take(expr,index) ++ [Float.to_string(ans)] ++ Enum.take(expr, index + 3 - length(expr))
	   evaluateMultDiv(newArray,index)
	 end
      else
 	 if index == length(expr) - 3 do
	   expr
	 else
	   evaluateMultDiv(expr,index + 2)
	 end
      end
    end
  end

  def evaluateAddSub(expr,index) do
    if length(expr) == 1 do
      Enum.at(expr,0)
    else
      if (Enum.at(expr,index + 1) == "+") || (Enum.at(expr,index + 1) == "-") do
	 ans = cond do
	   Enum.at(expr,index + 1) == "+" ->
	     parse_float(Enum.at(expr,index)) + parse_float(Enum.at(expr,index + 2))
	   Enum.at(expr,index + 1) == "-" ->
	     parse_float(Enum.at(expr,index)) - parse_float(Enum.at(expr,index + 2))
	 end
	 if index == length(expr) - 3 do
	   Enum.take(expr,index) ++ [Float.to_string(ans)]
	 else
	   newArray = Enum.take(expr,index) ++ [Float.to_string(ans)] ++ Enum.take(expr, index + 3 - length(expr))
	   evaluateAddSub(newArray,index)
	 end
      else
 	 if index == length(expr) - 3 do
	   expr
	 else
	   evaluateMultDiv(expr,index + 2)
	 end
      end
    end
  end

  #def evaluateExpr(operand1, rest) do
  #  [symbol | newRest] = rest
  #  [operand2 | remaining] = newRest
  #  answer = cond do
  #    symbol == "+" ->
  #      parse_float(operand1) + parse_float(operand2)
  #    symbol == "-" ->
  #      parse_float(operand1) - parse_float(operand2)
  #    symbol == "*" ->
  #      parse_float(operand1) * parse_float(operand2)
  #    symbol == "/" ->
  #      parse_float(operand1) / parse_float(operand2)
  #  end
  #  if length(remaining) == 0 do
  #  	answer
  #  else
  #     evaluateExpr(Float.to_string(answer),remaining)
  #  end
  #end

  def palindrome(input) do
    input == String.reverse(input)
  end

  def factor(x) do
    {inputValue, _} = Integer.parse(x)
    factors = []
    factors = isFactor(inputValue, 2)
    primeFactors = Enum.filter(factors, fn(val) -> length(isFactor(val,2)) == 1  end)
    allFactors = getAllFactors(inputValue,primeFactors,0,[])
    Enum.map(allFactors, fn(x) -> "\"" <> Integer.to_string(x) <> "\" " end)
  end

  def isFactor(x,currentValue) do
  if currentValue > x do
      []
    else
      if rem(x,currentValue) == 0 do
        [currentValue] ++ isFactor(x, (currentValue + 1))
      else
        isFactor(x, (currentValue + 1))
      end
    end
  end

  def getAllFactors(x, factors, index, newFactors) do
    if index == length(factors) do
      newFactors
    else
      intInput = Kernel.trunc(x)
      currentFactor = Enum.at(factors,index)
      if rem(intInput,currentFactor) == 0 do
	getAllFactors(x / currentFactor,factors,index,newFactors ++ [Enum.at(factors,index)])
      else
        getAllFactors(x,factors,index + 1,newFactors)
      end
    end
  end

end
