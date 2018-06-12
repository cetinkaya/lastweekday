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
