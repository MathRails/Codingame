# @param [Hash<String, Number>] The score corresponding to each mutant
# @param [Integer] The score threshold above which mutants should be ignored
# @return [String]
def best_remaining_mutant(mutant_scores, threshold)
  mutant_name = nil

  mutant_scores.each_pair do |name, score|
    if score <= threshold && (mutant_name.nil? || mutant_scores[mutant_name] < score)
      mutant_name = name
    end
  end

  return mutant_name
end