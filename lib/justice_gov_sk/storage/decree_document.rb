module JusticeGovSk
  module Storage
    class DecreeDocument < JusticeGovSk::Storage::Document
      def root
        @root ||= File.join super, 'decrees'
      end
    end
  end
end
