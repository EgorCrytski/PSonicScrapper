require_relative "./Classes/getProd"
require_relative "./Classes/writer"
require_relative "./Classes/getProdUrls"
require_relative "./Classes/getPage"


cat_url = ARGV.first
csv_name = ARGV.last

print "\n\nПолучаю список URL товаров в категории...\n\n"
get_prod_urls = GetProdUrlsClass.new
prod_urls = get_prod_urls.getProdUrls(cat_url)

print "\nПарсим товары по весовкам...\n\n"
get_prod = GetProdClass.new
prod_list = get_prod.getProd(prod_urls)

print "\nЗаписываем все в файл #{csv_name}\n"
writer = WriterClass.new
print "\nИтоговое число записей: #{prod_list[0].length}\n"
writer.writeToCSV(prod_list, csv_name)

print"\n\nГотово!\n"
