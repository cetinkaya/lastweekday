# Copyright 2018 Ahmet Cetinkaya

# This file is part of lastweekday.

# lastweekday is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# lastweekday is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with lastweekday.  If not, see <http://www.gnu.org/licenses/>.

require "date"

class Last
  def initialize(wdays=[0, 1, 2, 3, 4, 5, 6])
    @wdays = wdays
  end

  def or
    self
  end

  def of(month)
    monthdate = MonthInfo.new(month).monthdate

    last_day = Date.new(monthdate.year, monthdate.month, -1)
    last_day_wday = last_day.wday

    @wdays = [0, 1, 2, 3, 4, 5, 6] if @wdays.length == 0
    nearest_wday = @wdays.map{|d| d > last_day_wday ? d - 7 : d}.max
    last_day.prev_day(last_day_wday - nearest_wday)
  end

  def weekday
    Last.new([1, 2, 3, 4, 5])
  end

  def day
    Last.new([0, 1, 2, 3, 4, 5, 6])
  end

  def method_missing(method_name)
    days = Util.days

    mname = method_name.to_s
    i = days.map{ |d| d[0..mname.length-1]}.index(mname.downcase)
    if i
      new_wdays = (@wdays + [i]).uniq
      Last.new(new_wdays)
    else
      Last.new
    end
  end

  class<< self
    def method_missing(method_name, *args)
      Last.new([]).send(method_name, *args)
    end
  end
end

class LastWeekday
  class<< self
    def of(month)
      Last.weekday.of(month)
    end
  end
end

class First
  def initialize(wdays=[0, 1, 2, 3, 4, 5, 6])
    @wdays = wdays
  end

  def or
    self
  end

  def of(month)
    monthdate = MonthInfo.new(month).monthdate

    first_day = Date.new(monthdate.year, monthdate.month, 1)
    first_day_wday = first_day.wday

    @wdays = [0, 1, 2, 3, 4, 5, 6] if @wdays.length == 0
    nearest_wday = @wdays.map{|d| d < first_day_wday ? d + 7 : d}.min
    first_day.next_day(nearest_wday - first_day_wday)
  end

  def weekday
    First.new([1, 2, 3, 4, 5])
  end

  def day
    First.new([0, 1, 2, 3, 4, 5, 6])
  end

  def method_missing(method_name)
    days = Util.days

    mname = method_name.to_s
    i = days.map{ |d| d[0..mname.length-1]}.index(mname.downcase)
    if i
      new_wdays = (@wdays + [i]).uniq
      First.new(new_wdays)
    else
      First.new
    end
  end

  class<< self
    def method_missing(method_name, *args)
      First.new([]).send(method_name, *args)
    end
  end
end

class FirstWeekday
  class<< self
    def of(month)
      First.weekday.of(month)
    end
  end
end

class Nth
  def initialize(wday, n)
    @wday = wday
    @n = n
  end

  def of(month)
    MonthInfo.new(month).nth_occurrence(@wday, @n)
  end
end

class Second
  def initialize(wday=0)
    @wday = wday
  end

  def of(month)
    Nth.new(@wday, 2).of(month)
  end

  class<< self
    def method_missing(method_name, *args)
      self.new(Util.str_wday(method_name.to_s))
    end
  end
end

class Third
  def initialize(wday=0)
    @wday = wday
  end

  def of(month)
    Nth.new(@wday, 3).of(month)
  end

  class<< self
    def method_missing(method_name, *args)
      self.new(Util.str_wday(method_name.to_s))
    end
  end
end

class Fourth
  def initialize(wday=0)
    @wday = wday
  end

  def of(month)
    Nth.new(@wday, 4).of(month)
  end

  class<< self
    def method_missing(method_name, *args)
      self.new(Util.str_wday(method_name.to_s))
    end
  end
end

class Fifth
  def initialize(wday=0)
    @wday = wday
  end

  def of(month)
    Nth.new(@wday, 5).of(month)
  end

  class<< self
    def method_missing(method_name, *args)
      self.new(Util.str_wday(method_name.to_s))
    end
  end
end

class Util
  def Util.days
    ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
  end

  def Util.wday_str(wday)
    Util.days[wday%7]
  end

  def Util.str_wday(str)
    days = Util.days
    i = days.map{ |d| d[0..str.length-1]}.index(str.downcase)
    if i
      i
    else
      0
    end
  end

  def Util.months
    ["january", "february", "march", "april", "may", "june",
     "july", "august", "september", "october", "november", "december"]
  end

  def Util.month_str(month)
    Util.months[(month - 1)%12]
  end
end

class MonthInfo
  attr_reader :monthdate
  def initialize(month)
    today = Date.today
    @monthdate = today
    monstrs = Util.months
    case month
    when Integer
      if month <= 12 and month >= 1
        @monthdate = Date.new(today.year, month)
      else
        @monthdate = Date.new(month, today.month) # consider as a year
      end
    when String
      i = monstrs.map{ |m| m[0..month.length-1]}.index(month.downcase)
      if i
        @monthdate = Date.new(today.year, i + 1)
      end
    when Date
      @monthdate = month
    when Time
      @monthdate = month.to_date
    end
  end

  def day_count
    Date.new(@monthdate.year, @monthdate.month, -1).day
  end

  def first_occurrence(wday)
    month_first_wday = Date.new(@monthdate.year, @monthdate.month, 1).wday
    diff = wday - month_first_wday
    diff += 7 if diff < 0
    first_occurrence_day = diff + 1
    Date.new(@monthdate.year, @monthdate.month, first_occurrence_day)
  end

  def nth_occurrence(wday, n)
    wcount = wday_count(wday)
    raise "There are only #{wcount} #{Util.wday_str(wday).capitalize}s in #{@monthdate}!" if n > wcount
    raise "n should be larger than 0!" if n <= 0
    first_occurrence(wday).next_day((n-1)*7)
  end

  def wday_count(wday)
    1 + (day_count - first_occurrence(wday).day) / 7
  end
end
