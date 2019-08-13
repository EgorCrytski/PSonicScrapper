require 'csv'

class WriterClass

  def initialize
    end

    def writeToCSV(prod_list, csv_name)
      begin
        #Создаем файл по заданному маршруту и имени, добавляем Name, Price, Image в заголовок, в цикле производим запись данных в файл
          CSV.open(csv_name, "wb", write_headers: true, headers: ["Name", "Price", "Image"]) do |csv_string|
            for i in 0..prod_list[0].length-1
              csv_string << [prod_list[0][i], prod_list[1][i], prod_list[2][i]]
            end
          end
        return nil
      end
    end

  end
