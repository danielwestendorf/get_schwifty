# frozen_string_literal: true

class CalculatorCable < BaseCable
  def fibonacci
    n = current_user.fibonacci
    calculated = calculate_fibonacci(n)
    stream partial: "calculator/fibonacci", locals: { calculated: calculated, n: n }
  end

  private

  def calculate_fibonacci(n)
    return n if n <= 1
    calculate_fibonacci(n - 1) + calculate_fibonacci(n - 2)
  end
end
