if Rails.env.production?
  Rails.cache.clear
  puts 'Adminpanel cleared production cache successfully'
end
