defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&trans_word/1)
    |> Enum.join(" ")
  end

  def trans_word(word) do
    {prefix, remainder} = pig_split(word)
    remainder <> prefix <> "ay"
  end

  @vowels ["a", "e", "i", "o", "u"]
  @special_consonants ["qu"]
  @special_vowels ["xr", "yt"]

  def pig_split(word) do
  # Given a word, return a tuple {prefix, remainder} where
  #   prefix: the prefix is the part of the original word which should be placed at the end of the pig latin string (before ay)
  #   remainder: the body of the word, which should be moved to the front of the pig latin translation.
    <<first2::binary-size(2), rest2::binary>> = word
    cond do
      first2 in @special_vowels ->
        {"", word}

      first2 in @special_consonants ->
        {prefix, remainder} = pig_split(rest2)
        {first2 <> prefix, remainder}

      true ->
        <<first::binary-size(1), rest::binary>> = word
        if first in @vowels do
          {"", word}
        else
          {prefix, remainder} = pig_split(rest)
          {first <> prefix, remainder}
        end
    end

  end
end

