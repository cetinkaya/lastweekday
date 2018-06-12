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
    today = Date.today
    monthdate = today
    monstrs = ["january", "february", "march", "april", "may", "june",
               "july", "august", "september", "october", "november", "december"]
    case month
    when Integer
      if month <= 12 and month >= 1
        monthdate = Date.new(today.year, month)
      else
        monthdate = Date.new(month, today.month) # consider as a year
      end
    when String
      i = monstrs.map{ |m| m[0..month.length-1]}.index(month.downcase)
      if i
        monthdate = Date.new(today.year, i + 1)
      end
    when Date
      monthdate = month
    when Time
      monthdate = month.to_date
    end

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
    days = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]

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
