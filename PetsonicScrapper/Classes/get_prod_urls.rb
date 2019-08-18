require_relative '../Classes/get_page' # frozen_string_literal: true

class GetProdUrlsClass
  def initialize; end

  def get_prod_urls(cat_page_url)
    gp = GetPageClass.new
    # Выделяю пустой массив под хранение URL'ов товаров заданной категории
    prod_urls = []
    xp_str_url = "//a[@class='product_img_link product-list-category-img']"
    xp_str_count = "//span[@class = 'heading-counter']/text()"
    xp_str_catname = "//span[@class = 'cat-name']/text()"
    cat_page = gp.get_page(cat_page_url)
    page = 1
    curr_prod_num = 1
    # Парсим количество товаров в категории и ее название
    prod_count = cat_page.xpath(xp_str_count).to_s.split
    cat_name = cat_page.xpath(xp_str_catname).to_s
    print "#{prod_count[0]} товаров в категории '#{cat_name}'\n"
    loop do
      # Небольшой костыль для пагинации.
      #   Если page != 1, то к ссылке добавляется ?p=page
      #   при попытке открыть страницу с ?p=1
      #   происходит редирект на заглавную страницу категории
      #   и скрипт не может спарсить первую страницу
      cat_page =
        if page != 1
          gp.get_page("#{cat_page_url}?p=#{page}")
        else
          cat_page = gp.get_page(cat_page_url)
        end
      print "\nPage: #{page}\n\n"
      # Пробегаемся циклом по странице и парсим ссылки на товары
      cat_page.xpath(xp_str_url).each do |prod_url|
        prod_urls << prod_url[:href]
        print "url №#{curr_prod_num}: #{prod_url[:href]}\n"
        curr_prod_num += 1
      end
      page += 1
      # Как только количество ссылок будет равным количеству товаров в категории
      #   произойдет выход из цикла
      break unless curr_prod_num < prod_count[0].to_i
    end
    return prod_urls
  end
end
