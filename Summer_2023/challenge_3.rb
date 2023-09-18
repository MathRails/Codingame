# @param [Array<String>] A list of strings, where each string represents the contents of a file.
# @return [String] The contents of the merged file.
def merge_files(file_contents)
    mutants_list = Array.new
  
    file_contents.each do |file|
      file.split("\n").each do |ligne|
        mutant = Hash.new
        ligne.split(';').each do |propriete|
          name, value = propriete.delete("\n").split('=')
          mutant[name] = value
        end
  
        existing_mutant = mutants_list.select { |m| m["Name"] == mutant['Name'] }
        if !existing_mutant.empty?
          existing_mutant[0].merge!(mutant)
        else
          mutants_list << mutant
        end
      end
    end
  
    new_mutant_list = Array.new
    mutants_list.sort_by! { |el| el['Name'] }
    mutants_list.each do |subhash|
      keys = subhash.keys
      def_hash = Hash.new
  
      def_hash['Name'] = subhash['Name']
      keys.sort.each do |k|
        unless k == 'Name'
          def_hash[k] = subhash[k]
        end
      end
      new_mutant_list << def_hash
    end
  
    formatted_strings = new_mutant_list.map do |hash|
      pairs = hash.map { |key, value| "#{key}=#{value}" }
      pairs.join(";")
    end
  
    return formatted_strings.join("\n")
  end