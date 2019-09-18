require_relative './Classes/get_prod' # frozen_string_literal: true
require_relative './Classes/writer' # frozen_string_literal: true
require_relative './Classes/get_prod_urls' # frozen_string_literal: true
require_relative './Classes/get_page' # frozen_string_literal: true

cat_url = ARGV.first
csv_name = ARGV.last

#test push

print "\n\nПолучаю список URL товаров в категории...\n\n"
get_prod_urls = GetProdUrlsClass.new
prod_urls = get_prod_urls.get_prod_urls(cat_url)

print "\nПарсим товары по весовкам...\n\n"
get_prod = GetProdClass.new
prod_list = get_prod.get_prod(prod_urls)

print "\nЗаписываем все в файл #{csv_name}\n"
writer = WriterClass.new
print "\nИтоговое число записей: #{prod_list[0].length}\n"
writer.write_to_csv(prod_list, csv_name)

print "\n\nГотово!\n"
