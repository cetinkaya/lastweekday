# lastweekday
lastweekday provides a simple method to get the last weekday of a given month.

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
# Returns a Date object corresponding to the last weekday of June 2018
```

## Last Occurrence of a Particular Day in a Month

lastweekday library also has methods to ask for the last occurrence of a particular weekday in a month.

```ruby
require "lastweekday"

Last.tuesday.of("June")
# Returns a Date object corresponding to the last tuesday of June this year

Last.tuesday.or.wednesday("June")
# Returns a Date object corresponding to the last tuesday or wednesday
# (whichever comes last) of June this year

Last.day.of("June")
# Returns a Date object corresponding to June 30th of this year

Last.weekday.of("June")
# Returns a Date object corresponding to the last weekday of June this year

Last.new([0,2,4]).of("June")
# Returns a Date object corresponding to the last Sunday (0) or Tuesday (2)
# or Thursday (4) (whichever comes last) of June this year
```

## Other Examples

```ruby
require "lastweekday"

puts Last.monday.of(Date.new(2018, 12)) # 2018-12-31 (December 31, 2018 is a monday)
puts Last.saturday.of(Date.new(2019, 1)) # 2019-01-26
puts Last.thu.or.fri.of(Date.new(2019, 1)) # 2019-01-31 (which is a thursday)
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
