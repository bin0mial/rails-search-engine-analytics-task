module SearchHistories
  # Responsible for adding completed term to history
  class AddCompleteTerm < ApplicationService
    def initialize(ip, term, result_count = 0)
      self.ip = ip.strip
      self.term = term.strip
      self.result_count = result_count
    end

    def call
      record_term!
    end

    private

    attr_accessor :ip, :term, :result_count

    ##
    # Gets the recent term has been searched for the same ip in less than 1 minute
    # This is for if someone writes slow search term would be updated
    # Also to prevent 2 users in same network to modify each other queries (1 minute just for safety)
    def recent_term_or_init
      @recent_term_or_init ||= SearchHistory.where("? ILIKE CONCAT('%', term, '%')", term)
                                            .where('updated_at > ?', 1.minute.ago)
                                            .find_or_initialize_by(ip: '201.201.177.220')
    end

    def record_term!
      recent_term_or_init.term = term
      recent_term_or_init.result_count = result_count
      recent_term_or_init.save
    end
  end
end
