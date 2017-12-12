use Bitwise

defmodule SecretHandshake do
  # Use an array, since the order of the code words matters.
  @command_map [
    {0b1, "wink"},
    {0b10, "double blink"},
    {0b100, "close your eyes"},
    {0b1000, "jump"},
  ]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do

    handshake = for {check_bit, phrase} <- @command_map, (code &&& check_bit) == check_bit do
      phrase
    end

    # Reverse if needed
    if (code &&& 0b10000) == 0b10000 do
      Enum.reverse(handshake)
    else
      handshake
    end

  end
end

