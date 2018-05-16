# == Seeds Directory ========================================================= #

filepath = File.join(File.dirname(__FILE__),"seeds")

# == Seed Users ============================================================== #

if User.all.empty?
  puts "== seeds.rb User: seeding ".ljust(79, "=")
  puts "-- create users (100)"
  t_start = Time.now

  colnames  = ["username", "email", "password"]
  usernames = File.read(File.join(filepath,"usernames.dat")).gsub(/\s/,"  ").split(/ {2,}/)
  emails    = usernames.collect{|username| username + "@mytrav.com"}
  passwords = usernames.collect{SecureRandom.hex}
  user_info = [usernames, emails, passwords].transpose

  file = File.new(File.join(filepath,"out.txt"), "w")
  file.puts "#{"USERNAME".ljust(18)}#{"EMAIL".ljust(29)}#{"PASSWORD"}"
  user_info.each.with_index(1) do |arr, cnt|
    print "\r   -> %d" % cnt
    attributes = arr.map.with_index{|attribute, i| [colnames[i], attribute]}.to_h
    user = User.new(attributes)
    if !!user.save
      file.puts "#{arr[0].ljust(18)}#{arr[1].ljust(29)}#{arr[2]}"
    end
  end
  file.close
  puts "\r   -> %.4fs" % (Time.now - t_start)
  puts "== seeds.rb User: seeded #{"(%.4fs)" % (Time.now - t_start)} ".ljust(79, "=")
  puts
end

# == Seed Destinations ======================================================= #

if Destination.all.empty?
  puts "== seeds.rb Destination: seeding ".ljust(79, "=")
  puts "-- create destinations (100)"
  t_start = Time.now

  names = File.read(File.join(filepath,"destinations.dat")).gsub(/[^\S \r\n]/,"").split("\n")
  names.each.with_index(1) do |name, cnt|
    print "\r   -> %d" % cnt
    Destination.create(:name => name)
  end
  puts "\r   -> %.4fs" % (Time.now - t_start)
  puts "== seeds.rb Destination: seeded #{"(%.4fs)" % (Time.now - t_start)} ".ljust(79, "=")
  puts
end

# == Seed Travels ============================================================ #

if Travel.all.empty?
  puts "== seeds.rb Travel: seeding ".ljust(79, "=")
  puts "-- create travels (0-10 per user)"
  t_start = Time.now

  ta = Time.new(2000).to_f
  tb = (Time.now + 2.years).to_f

  User.all.each.with_index(1) do |user, cnt|
    print "\r   -> %d" % cnt
    [*0..10].sample.times do
      da = Time.at( ta + rand * (tb-ta) ).to_date
      db = ([da]*15).map.with_index{|d,i| d+i.days}.unshift(nil).sample
      attributes = {
        :destination_id => [*1..Destination.all.size].sample,
        :purpose        => %w[Business Conference Honeymoon Leisure Pleasure R&R Vacation Work].unshift(nil).sample,
        :start_date     => da.to_s,
        :end_date       => db.to_s}
      user.travels.create(attributes)
    end
  end
  puts "\r   -> %.4fs" % (Time.now - t_start)
  puts "== seeds.rb Travel: seeded #{"(%.4fs)" % (Time.now - t_start)} ".ljust(79, "=")
  puts
end

# == Seed Travel Logs ======================================================== #

if Log.all.empty?
  puts "== seeds.rb Log: seeding ".ljust(79, "=")
  puts "-- create logs (0-5 per travel)"
  t_start = Time.now

  titles  = File.read(File.join(filepath,"log_titles.dat")).gsub(/[^\S \r\n]/,"").split("\n")
  content = "Lorem ipsum dolor sit amet, consectetur adipisicing elit,
             sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
             Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
             nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
             reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
             pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
             culpa qui officia deserunt mollit anim id est laborum."

  Travel.all.each.with_index(1) do |travel, cnt|
    print "\r   -> %d" % cnt
    [*0..5].sample.times do
      attributes = {
        :title   => titles.sample,
        :content => content}
      travel.logs.create(attributes)
    end
  end
  puts "\r   -> %.4fs" % (Time.now - t_start)
  puts "== seeds.rb Log: seeded #{"(%.4fs)" % (Time.now - t_start)} ".ljust(79, "=")
  puts
end
