require 'csv' # frozen_string_literal: true

class WriterClass
  def initialize; end

  def write_to_csv(prod_list, csv_name)
    # Создаем файл по заданному маршруту и имени
    #   добавляем Name, Price, Image в заголовок
    #   в цикле производим запись данных в файл
    CSV.open(csv_name, 'wb', write_headers: true, headers: %w[Name Price Image]) do |csv_string|
      for i in 0..prod_list[0].length - 1
        csv_string << [prod_list[0][i], prod_list[1][i], prod_list[2][i]]
      end
    end
  end
end
