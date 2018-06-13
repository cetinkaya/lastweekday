# lastweekday
lastweekday provides a simple Ruby method to get the last weekday of a given month.

## Examples

```ruby
require "lastweekday"

LastWeekday.of(6)
# Returns a Date object corresponding to the last weekday of June this year
```

```ruby
require "lastweekday"

LastWeekday.of("June")
# Returns a Date object corresponding to the last weekday of June this year
```

```ruby
require "lastweekday"

LastWeekday.of(Date.new(2018, 6, 1))
# Returns a Date object corresponding to the last weekday of June 2018 (June 29, 2018)
```

## Last Occurrence of a Particular Day in a Month

lastweekday library also has methods to ask for the last occurrence of a particular day in a month.

```ruby
require "lastweekday"

Last.tuesday.of("June")
# Returns a Date object corresponding to the last Tuesday of June this year

Last.tuesday.or.wednesday.of("June")
# Returns a Date object corresponding to the last Tuesday or Wednesday
# (whichever comes last) of June this year

Last.day.of("June")
# Returns a Date object corresponding to June 30th of this year

Last.weekday.of("June")
# Returns a Date object corresponding to the last weekday of June this year

Last.new([0,2,4]).of("June")
# Returns a Date object corresponding to the last Sunday (0) or Tuesday (2)
# or Thursday (4) (whichever comes last) of June this year
```

## Nth Occurrence of a Particular Day in a Month

lastweekday library also has methods to ask for the nth occurrence of a particular day in a month.

```ruby
Second.sunday.of(5)
# Returns a Date object corresponding to the 2nd Sunday of May this year

Second.sunday.of(Date.new(2019, 5))
# Returns a Date object corresponding to the 2nd Sunday of May 2019

First.day.of("June")
# Returns a Date object corresponding to the 1st date of June this year

First.sunday.or.monday.of(Date.new(2019, 6))
# Returns a Date object corresponding to the first Sunday or Monday
# (whichever comes first) of June 2019 (Sunday comes first in June 2019)
```

## Other Examples

```ruby
require "lastweekday"

puts Last.monday.of(Date.new(2018, 12)) # 2018-12-31 (December 31, 2018 is a Monday)
puts Last.saturday.of(Date.new(2019, 1)) # 2019-01-26
puts Last.thu.or.fri.of(Date.new(2019, 1)) # 2019-01-31 (which is a Thursday)
puts Second.sunday.of(Date.new(2018, 5)) # 2018-05-13
puts Second.sunday.of(Date.new(2019, 5)) # 2019-05-12
puts First.sat.of(Date.new(2018, 6)) # 2018-06-02
puts Third.tuesday.of(Date.new(2018, 6)) # 2018-06-19
```

## Installation

A .gem file can be built by:

```sh
git clone https://github.com/cetinkaya/lastweekday.git
cd lastweekday
gem build lastweekday.gemspec
```

To install the local gem file, use:

```sh
gem install --local lastweekday-0.1.gem
```
