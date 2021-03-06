module CalendariumRomanum

  # knows the fixed-date celebrations
  class Sanctorale

    def initialize
      @days = {}

      @solemnities = {}
    end

    attr_reader :solemnities

    def add(month, day, celebration)
      date = AbstractDate.new(month, day)
      unless @days.has_key? date
        @days[date] = []
      end

      if celebration.solemnity?
        @solemnities[date] = celebration
      end

      @days[date] << celebration
    end

    # replaces content of the given day by given celebrations
    def replace(month, day, celebrations)
      date = AbstractDate.new(month, day)

      if celebrations.first.solemnity?
        @solemnities[date] = celebrations.first
      elsif @solemnities.has_key? date
        @solemnities.delete date
      end

      @days[date] = celebrations
    end

    # adds all Celebrations from another instance
    def update(sanctorale)
      sanctorale.each_day do |date, celebrations|
        replace date.month, date.day, celebrations
      end
    end

    # returns an Array with one or more Celebrations
    # scheduled for the given day
    #
    # expected arguments: Date or two Integers (month, day)
    def get(*args)
      if args.size == 1 && args[0].is_a?(Date)
        month = args[0].month
        day = args[0].day
      else
        month, day = args
      end

      date = AbstractDate.new(month, day)
      return @days[date] || []
    end

    # for each day for which an entry is available
    # yields an AbstractDate and an Array of Celebrations
    def each_day
      @days.each_pair do |date, celebrations|
        yield date, celebrations
      end
    end

    # returns count of the _days_ with celebrations filled
    def size
      @days.size
    end

    def empty?
      @days.empty?
    end
  end
end
