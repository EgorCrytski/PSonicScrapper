require_relative '../Classes/get_page' # frozen_string_literal: true

class GetProdClass
  def initialize; end

  def get_prod(prod_urls)
    gp = GetPageClass.new
    # Выделяю массивы под имя + весовку, цену, URL картинки
    prod_list_name = []
    prod_list_price = []
    prod_list_pic = []
    xp_str_prodname = "//h1[@itemprop = 'name']/text()"
    xp_str_prodpic = "//img[@id='bigpic']/@src"
    xp_str_attlist = "//label//span[@class='radio_label']"
    xp_str_pricelist = "//label//span[@class='price_comb']"

    # В цикле перебираем все URL товаров
    prod_urls.each do |prod_url|
      prod_page = gp.get_page(prod_url)
      prod_name = prod_page.xpath(xp_str_prodname).to_s
      # В редких случаях ссылки на товары являются битыми, если ссылка битая,
      #   то при попытке спарсить имя получим ""
      #   данная конструкция if пропускает товары с битыми ссылками
      if prod_name != ''
        prod_name = prod_name.sub(' ', '')
        prod_pic = prod_page.xpath(xp_str_prodpic)
        print "\n#{prod_name}\n"
        prod_att_list = prod_page.xpath(xp_str_attlist)
        prod_price_list = prod_page.xpath(xp_str_pricelist)
        print "Вариаций весовок для этого товара: #{prod_att_list.length}\n"

        # Пробегаемся по вариациям весовок и добавляем всю информацию в массивы
        for j in 0..prod_att_list.length - 1
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

      end
    end
    # Создаем массив, содержащий в себе подмассивы с информацией
    prod_list = [prod_list_name, prod_list_price, prod_list_pic]
    print "Итоговое число товаров: #{prod_list[0].length}\n"
    return prod_list
  end
end
