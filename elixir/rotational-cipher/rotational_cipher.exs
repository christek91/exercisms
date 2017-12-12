defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&encipher(&1, shift))
    |> to_string
  end

  # Lowercase
  def encipher(character, shift) when character in ?a..?z do
    rem(character - ?a + shift, 26) + ?a
  end

  # Uppercase
  def encipher(character, shift) when character in ?A..?Z do
    rem(character - ?A + shift, 26) + ?A
  end

  # Everything else.
  def encipher(character, shift) do
    character
  end

end

