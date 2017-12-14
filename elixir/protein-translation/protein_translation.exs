defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna("") do
    {:ok, []}
  end

  def of_rna(rna) do
    <<codon::binary-size(3), rest::binary>> = rna
    with {:ok, protein} <- of_codon(codon),
          {:ok, remaining_rna} <- of_rna(rest)
    do
      if protein == "STOP" do
        {:ok, []}
      else
        {:ok, [protein | remaining_rna]}
      end

    else
      {:error, _} -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case codon do
      n when n in ["UGU", "UGC"] ->
        {:ok, "Cysteine"}
      n when n in ["UUA", "UUG"] ->
        {:ok, "Leucine"}
      n when n in ["AUG"] ->
        {:ok, "Methionine"}
      n when n in ["UUU", "UUC"] ->
        {:ok, "Phenylalanine"}
      n when n in ["UCU", "UCC", "UCA", "UCG"] ->
        {:ok, "Serine"}
      n when n in ["UGG"] ->
        {:ok, "Tryptophan"}
      n when n in ["UAU", "UAC"] ->
        {:ok, "Tyrosine"}
      n when n in ["UAA", "UAG", "UGA"] ->
        {:ok, "STOP"}
      _ ->
        {:error, "invalid codon"}
    end
  end
end

