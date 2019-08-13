require_relative '../Classes/getPage'


class GetProdUrlsClass

  def initialize
    end

    def getProdUrls(cat_page_url)
      begin
        gp = GetPageClass.new
        # Выделяю пустой массив под хранение URL'ов товаров заданной категории
        prod_urls = []
        cat_paged_url = cat_page_url
        cat_page = gp.getPage(cat_page_url)

        # Парсим количество товаров в категории и ее название
        prod_count = (cat_page.css('span.heading-counter').inner_html).split()
        cat_name = cat_page.css('span.cat-name').inner_html

        print "#{prod_count[0]} товаров в категории '#{cat_name}'\n"
        page = 1
        i = 1
        begin
        # Небольшой костыль для пагинации. Если page != 1, то к ссылке добавляется ?p=page
        # при попытке открыть страницу с ?p=1, происходит редирект на заглавную страницу категории
        # и скрипт не может спарсить первую страницу
        if page != 1
          cat_paged_url = ("#{cat_page_url}"+"?p="+"#{page}")
          cat_page = gp.getPage(cat_paged_url)
        end

        print "\nPage: #{page}\n #{cat_paged_url}\n\n"

        # Пробегаемся циклом по странице и парсим ссылки на товары
        prod_list = cat_page.css('div.pro_first_box')

        prod_list.each do |prod|
          url = prod.at('a')['href']
          prod_urls << url
          print "url №#{i} ", url, "\n"
          i = i + 1
        end

        page = page + 1
        # Как только количество полученных ссылок будет равным количеству товаров в категории, произойдет выход из цикла
      end while i <= prod_count[0].to_i
      return prod_urls

    end
  end
end
