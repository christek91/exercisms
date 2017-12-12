defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
  	chars = to_charlist text
  	to_string rotate_helper(chars, shift)
  end

  def rotate_helper([c | tail], shift) do
  	lowercase = c - ?a
  	uppercase = c - ?A
  	cond do
  	  	lowercase >= 0 && lowercase <= 26 ->
  			[rem(lowercase + shift, 26) + ?a | rotate_helper(tail, shift)]

  	  	uppercase >= 0 && uppercase <= 26 ->
  			[rem(uppercase + shift, 26) + ?A | rotate_helper(tail, shift)]

  		true ->
  			[c | rotate_helper(tail, shift)]
  	end

  end

  def rotate_helper([], shift) do
  	[]
  end
end

