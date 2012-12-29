module JusticeGovSk
  module Jobs
    class CrawlerJob
      @queue = :crawlers

      # supported types: Court, CivilHearing, SpecialHearing, CriminalHearing, Decree
      def self.perform(type, url, options = {})
        options.symbolize_keys!
        
        JusticeGovSk::Helpers::CrawlerHelper.crawl_resource type, url, options
      end
    end
  end
end