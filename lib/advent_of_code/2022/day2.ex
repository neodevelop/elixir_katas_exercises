defmodule AdventOfCode.Year2022.Day2 do

	def compute_score(guide) do
    guide
    |> handle_input()
    |> Enum.map(&input_player_2/1)
    |> Enum.map(&play_game/1)
    |> Enum.map(&get_points/1)
    |> Enum.sum()
	end

  def compute_score_2(guide) do
    guide
    |> handle_input()
    |> Enum.map(&expected_result/1)
    |> Enum.map(&play_game_2/1)
    |> Enum.map(&get_points/1)
    |> Enum.sum()
  end

  defp handle_input(guide) do
    guide
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&input_player_1/1)
  end

  defp input_player_1(["A", e]), do: [:rock, e]
  defp input_player_1(["B", e]), do: [:paper, e]
  defp input_player_1(["C", e]), do: [:scissors, e]

  defp input_player_2([e, "X"]), do: [e, :rock]
  defp input_player_2([e, "Y"]), do: [e, :paper]
  defp input_player_2([e, "Z"]), do: [e, :scissors]

  defp expected_result([e, "X"]), do: [e, :lost]
  defp expected_result([e, "Y"]), do: [e, :draw]
  defp expected_result([e, "Z"]), do: [e, :won]

  defp play_game([:rock, :scissors]), do: [:rock, :scissors, :lost]
  defp play_game([:rock, :paper]), do: [:rock, :paper, :won]
  defp play_game([:paper, :rock]), do: [:paper, :rock, :lost]
  defp play_game([:paper, :scissors]), do: [:paper, :scissors, :won]
  defp play_game([:scissors, :paper]), do: [:scissors, :paper, :lost]
  defp play_game([:scissors, :rock]), do: [:scissors, :rock, :won]
  defp play_game([a, a]), do: [a, a, :draw]

  defp play_game_2([:rock, :lost]), do: [:rock, :scissors, :lost]
  defp play_game_2([:rock, :won]), do: [:rock, :paper, :won]
  defp play_game_2([:paper, :lost]), do: [:paper, :rock, :lost]
  defp play_game_2([:paper, :won]), do: [:paper, :scissors, :won]
  defp play_game_2([:scissors, :lost]), do: [:scissors, :paper, :lost]
  defp play_game_2([:scissors, :won]), do: [:scissors, :rock, :won]
  defp play_game_2([a, :draw]), do: [a, a, :draw]

  defp get_points([_, :rock, status]), do: 1 + get_status_points(status)
  defp get_points([_, :paper, status]), do: 2 + get_status_points(status)
  defp get_points([_, :scissors, status]), do: 3 + get_status_points(status)

  defp get_status_points(:lost), do: 0
  defp get_status_points(:draw), do: 3
  defp get_status_points(:won), do: 6

end