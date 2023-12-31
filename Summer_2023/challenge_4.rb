def find_correct_path(instructions, target)
    eureka = false
    result = ""
    alternatives = {
      'FORWARD' => ['BACK', 'TURN LEFT', 'TURN RIGHT'],
      'BACK' => ['FORWARD', 'TURN LEFT', 'TURN RIGHT'],
      'TURN LEFT' => ['BACK', 'FORWARD', 'TURN RIGHT'],
      'TURN RIGHT' => ['BACK', 'TURN LEFT', 'FORWARD']
    }
  
    while !eureka
        res, index, instruction = try_alternatives(instructions, alternatives, target)
        if res
          result = "Replace instruction #{index + 1} with #{instruction}"
          eureka = true
        end
      end    
      return result
  end

  def try_alternatives(instructions, alternatives, target)
    instructions.each_with_index do |instruction, index|
      alternatives[instruction].each do |instruction_replacement|
        instructions_test = instructions.dup
        instructions_test[index] = instruction_replacement
        res = try(instructions_test, target)
        return res, index, instruction_replacement if res
      end
    end
    return nil, nil, nil
  end
    
  def try(instructions, target)
    test_position = [0, 0]
    direction = 'R'
    instructions.each do |instruction|
      case instruction
      when 'TURN RIGHT'
        direction = new_direction(direction, instruction)
      when 'TURN LEFT'
        direction = new_direction(direction, instruction)
      when 'FORWARD'
        if direction == 'R'
          test_position[0] += 1
        elsif direction == 'L'
          test_position[0] -= 1
        elsif direction == 'U'
          test_position[1] += 1
        elsif direction == 'D'
          test_position[1] -= 1
        end
      when 'BACK'
        if direction == 'R'
          test_position[0] -= 1
        elsif direction == 'L'
          test_position[0] += 1
        elsif direction == 'U'
          test_position[1] -= 1
        elsif direction == 'D'
          test_position[1] += 1
        end
      end
    end  
    return true if test_position ==target
  end
  
def new_direction(current_direction, action)
    directions = {
      'TURN LEFT' => {
        'R' => 'U',
        'U' => 'L',
        'L' => 'D',
        'D' => 'R'
      },
      'TURN RIGHT' => {
        'R' => 'D',
        'D' => 'L',
        'L' => 'U',
        'U' => 'R'
      }
    }
    return directions[action][current_direction]
  end
