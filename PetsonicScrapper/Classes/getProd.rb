require_relative '../Classes/getPage'


class GetProdClass
  def initialize
  end

  def getProd(prod_urls)
    begin
      gp = GetPageClass.new
      # Выделяю массивы под имя + весовку, цену, URL картинки
      prod_list_name = []
      prod_list_price = []
      prod_list_pic = []

      # В цикле перебираем все URL товаров
      prod_urls.each do |prod_url|
        prod_page = gp.getPage(prod_url)
        prod_name = prod_page.css('h1.product_main_name').inner_html

        # В редких случаях ссылки на товары являются битыми, если ссылка битая, то при попытке спарсить имя получим "".
        # Cоответственно, данная конструкция if пропускает товары с битыми ссылками
        if prod_name != ""
          prod_name = prod_name.sub(' ','')
          prod_pic = prod_page.css('span#view_full_size').css('img#bigpic').at('img')['src']
          print prod_name, "\n"
          prod_att_list = prod_page.xpath("//label//span[@class='radio_label']")
          prod_price_list = prod_page.xpath("//label//span[@class='price_comb']")
          print "Вариаций весовок для этого товара: #{prod_att_list.length}\n"

          # Пробегаемся по вариациям весовок и добавляем всю информацию в массивы
          for j in 0..prod_att_list.length-1
            att = prod_att_list[j]
            price = prod_price_list[j]
            prod_att = att.content
            print "#{prod_att} "
            prod_price = price.content
            print "#{prod_price}\n"
            prod_list_name << "#{prod_name} #{prod_att}"
            prod_list_price << prod_price
            prod_list_pic << prod_pic
          end
          print "\n"
        end
      end
      # Создаем массив, содержащий в себе подмассивы с информацией
      prod_list = [prod_list_name, prod_list_price, prod_list_pic]
      print "\nИтоговое число товаров: #{prod_list[0].length}\n\n"
      return prod_list
    end
  end

end
