defmodule Practice.Factor do
  
  def parse_int(input) do
    case Integer.parse(input) do
      {num, _} -> num
      _ -> 0
    end
  end
  
  def factor_helper(input, i) do
    if rem(input, i) == 0 do
      i
    else 
      factor_helper(input, i + 1)
    end
  end
  
  def factor(input, factorsList) when input == 1 do
    factorsList
  end

  def factor(input, factorsList) do
    factor = factor_helper(input, 2)
    factor(div(input, factor), factorsList ++ [factor])
  end
    

  def factor(input) do
    if is_integer(input) do
      factor(input, [])
    else
      factor(parse_int(input), [])
    end
  end
end

