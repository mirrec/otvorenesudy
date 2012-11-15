# encoding: utf-8

module JusticeGovSk
  module Parsers
    class CriminalHearingParser < HearingParser
      def type(document)
        'Trestné'
      end
      
      def defendants(document)
        find_rows_by_group 'defendants', document, 'Obžalovaní' do |divs|
          map  = {}
          name = nil

          divs.each do |div|
            if div[:class] == 'popiska'
              name = div.text.strip
              map[name] = []
            elsif div[:class] == 'hodnota'
              map[name] << div.text.gsub(/\A-\s+§/, '')
            end
          end

          map   
        end
      end
      
      def accusation(value)
        value
      end
    end
  end
end
