module SudnaradaGovSk
  class Parser
    class JudgePropertyDeclarationList < SudnaradaGovSk::Parser::List
      def list(document)
        find_values 'list', document, 'table.table_list tr[class^=tab]', verbose: false do |rows|
          items = []
          
          rows.each do |row|
            data = row.search('td')
            
            data.search('a').each do |a|
              url   = "#{SudnaradaGovSk::URL.base}#{a[:href].ascii}"
              court = data[1].text
              judge = data[0].text
              
              items << { url: url, court: court, judge: judge } 
            end
          end
          
          items
        end
      end
      
      def page(document)
        @page ||= find_value 'page', document, 'div.pagelist b' do |bold|
          bold.text.to_i - 1
        end
      end
      
      def pages(document)
        @pages ||= find_value 'pages', document, 'div.pagelist a' do |anchors|
          pages = nil
          
          anchors.reverse.each do |anchor|
            if anchor.text =~ /\d+/
              pages = anchor.text.to_i
              break
            end 
          end
          
          pages
        end
      end
      
      def per_page(document)
        nil
      end
    end
  end
end
