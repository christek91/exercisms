defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([h|t], fun) do
    result = keep(t, fun)
    if fun.(h), do: [h|result], else: result
  end

  def keep([], _) do
    []
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard([h|t], fun) do
    result = discard(t, fun)
    if not fun.(h), do: [h|result], else: result
  end

  def discard([], _) do
    []
  end
end
