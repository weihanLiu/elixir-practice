defmodule Practice.Calc do
  def parse_float(text) do
    case Float.parse(text) do
       {num, _} -> num
       _ -> 0
    end
  end

  def tag_token_helper(token) do
    cond do
      token == "+" || token == "-" || token == "*" || token == "/" -> {:opr, token}
      true -> {:num, parse_float(token)}
    end
  end

  def tag_token(list) do
    Enum.map(list, &tag_token_helper/1)
  end

  
  def prece_opr(token) do
    cond do
      token == "+" || token == "-" -> 0
      token == "*" || token == "/" -> 1
      true -> -1
    end
  end    


  def apply_opr(result, opr) do
    first = hd(result)
    second = hd(tl(result))
    
    rest = tl(tl(result))
    cond do
      opr == "+" -> [second + first | rest]
      opr == "-" -> [second - first | rest]
      opr == "*" -> [second * first | rest]
      opr == "/" -> [second / first | rest]
    end
  end

  def valid_opr(opr) do
    cond do
      opr == "+" || opr == "-" || opr == "*" || opr == "/" -> true
      true-> false
    end
  end

  def calc_helper([], [result_hd | _result_tl], []) do
    result_hd
  end

  def calc_helper([], result, [opr_hd | opr_tl]) do
    calc_helper([], apply_opr(result, opr_hd), opr_tl)
  end

  def calc_helper([exprList_hd | exprList_tl], result, opr) do
    if valid_opr(exprList_hd) do
      if length(opr) != 0 && prece_opr(hd(opr)) >= prece_opr(exprList_hd) do
        calc_helper([exprList_hd | exprList_tl], apply_opr(result, hd(opr)), tl(opr))
      else
        calc_helper(exprList_tl, result, [exprList_hd | opr])
      end
    else 
      calc_helper(exprList_tl, [parse_float(exprList_hd) | result], opr)
    end
  end

  def calc_helper(exprList) do
    calc_helper(exprList, [], [])
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> calc_helper
  end
end

