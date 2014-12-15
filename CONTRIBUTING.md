Consider starting the commit message with an applicable emoji:

* :lipstick: `:lipstick:` when improving the format/structure of the code
* :racehorse:`:racehorse:` when improving performance
* :memo:`:memo:` when writing docs
* :bug:`:bug:` when fixing a bug
* :fire:`:fire:` when removing code or files
* :green_heart:`:green_heart:` when fixing the CI build
* :white_check_mark:`:white_check_mark:` when adding tests

Favor single quotes when not concatenating, double quotes are prefered when concatenating, escaping characters or using a single quote in the string:

Single Quotes:
`puts 'hello world'`
Double Quotes:
```
h = 'hello'
w = 'world'
puts "#{h}, #{w}"
puts "\n hi"
puts "it's 6 am"
```
