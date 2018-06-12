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

class LastWeekday
  class<< self
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
      if last_day_wday <= 5 and last_day_wday >= 1
        last_day
      elsif last_day_wday == 6
        last_day.prev_day
      else
        last_day.prev_day(2)
      end
    end
  end
end
