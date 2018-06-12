# lastweekday
lastweekday provides a simple method to get the last weekday of a given month.


# Examples

```ruby
require "lastweekday"

LastWeekday.of(6)
# Returns a Date object corresponding to last week day of June this year
```

```ruby
require "lastweekday"

LastWeekday.of("June")
# Returns a Date object corresponding to last week day of June this year
```

```ruby
require "lastweekday"

LastWeekday.of(Date.new(2018, 6, 1))
# Returns a Date object corresponding to last week day of June 2018
```

