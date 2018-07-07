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

  # http://www.blindtextgenerator.com/lorem-ipsum
  titles  = File.read(File.join(filepath,"log_titles.dat")).gsub(/[^\S \r\n]/,"").split("\n")
  content = ["Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean
             commodo ligula eget dolor. Aenean massa. Cum sociis natoque
             penatibus et magnis dis parturient montes, nascetur ridiculus mus.
             Donec quam felis, ultricies nec, pellentesque eu, pretium quis,
             sem. Nulla consequat massa quis enim. Donec pede justo, fringilla
             vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,
             imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede
             mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum
             semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula,
             porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem
             ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus
             viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean
             imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper
             ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus,
             tellus eget condimentum rhoncus, sem quam semper libero, sit amet
             adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus
             pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt
             tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam
             quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis
             leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis
             magna.",
             "But I must explain to you how all this mistaken idea of denouncing
             pleasure and praising pain was born and I will give you a complete
             account of the system, and expound the actual teachings of the
             great explorer of the truth, the master-builder of human happiness.
             No one rejects, dislikes, or avoids pleasure itself, because it is
             pleasure, but because those who do not know how to pursue pleasure
             rationally encounter consequences that are extremely painful. Nor
             again is there anyone who loves or pursues or desires to obtain
             pain of itself, because it is pain, but because occasionally
             circumstances occur in which toil and pain can procure him some
             great pleasure. To take a trivial example, which of us ever
             undertakes laborious physical exercise, except to obtain some
             advantage from it? But who has any right to find fault with a man
             who chooses to enjoy a pleasure that has no annoying consequences,
             or one who avoids a pain that produces no resultant pleasure? On
             the other hand, we denounce with righteous indignation and dislike
             men who are so beguiled and demoralized by the charms of pleasure
             of the moment, so blinded by desire, that they cannot foresee the
             pain and trouble that are bound to ensue; and equal blame belongs
             to those who fail in their duty through weakness of will, which is
             the same as saying through shrinking from toil and pain.",
             "The European languages are members of the same family. Their
             separate existence is a myth. For science, music, sport, etc,
             Europe uses the same vocabulary. The languages only differ in their
             grammar, their pronunciation and their most common words. Everyone
             realizes why a new common language would be desirable: one could
             refuse to pay expensive translators. To achieve this, it would be
             necessary to have uniform grammar, pronunciation and more common
             words. If several languages coalesce, the grammar of the resulting
             language is more simple and regular than that of the individual
             languages. The new common language will be more simple and regular
             than the existing European languages. It will be as simple as
             Occidental; in fact, it will be Occidental. To an English person,
             it will seem like simplified English, as a skeptical Cambridge
             friend of mine told me what Occidental is.The European languages
             are members of the same family. Their separate existence is a myth.
             For science, music, sport, etc, Europe uses the same vocabulary.
             The languages only differ in their grammar, their pronunciation and
             their most common words. Everyone realizes why a new common
             language would be desirable: one could refuse to pay expensive
             translators.",
             "Far far away, behind the word mountains, far from the countries
             Vokalia and Consonantia, there live the blind texts. Separated they
             live in Bookmarksgrove right at the coast of the Semantics, a large
             language ocean. A small river named Duden flows by their place and
             supplies it with the necessary regelialia. It is a paradisematic
             country, in which roasted parts of sentences fly into your mouth.
             Even the all-powerful Pointing has no control about the blind texts
             it is an almost unorthographic life One day however a small line of
             blind text by the name of Lorem Ipsum decided to leave for the far
             World of Grammar. The Big Oxmox advised her not to do so, because
             there were thousands of bad Commas, wild Question Marks and devious
             Semikoli, but the Little Blind Text didn’t listen. She packed her
             seven versalia, put her initial into the belt and made herself on
             the way. When she reached the first hills of the Italic Mountains,
             she had a last view back on the skyline of her hometown
             Bookmarksgrove, the headline of Alphabet Village and the subline of
             her own road, the Line Lane.",
             "A wonderful serenity has taken possession of my entire soul, like
             these sweet mornings of spring which I enjoy with my whole heart. I
             am alone, and feel the charm of existence in this spot, which was
             created for the bliss of souls like mine. I am so happy, my dear
             friend, so absorbed in the exquisite sense of mere tranquil
             existence, that I neglect my talents. I should be incapable of
             drawing a single stroke at the present moment; and yet I feel that
             I never was a greater artist than now. When, while the lovely
             valley teems with vapour around me, and the meridian sun strikes
             the upper surface of the impenetrable foliage of my trees, and but
             a few stray gleams steal into the inner sanctuary, I throw myself
             down among the tall grass by the trickling stream; and, as I lie
             close to the earth, a thousand unknown plants are noticed by me:
             when I hear the buzz of the little world among the stalks, and grow
             familiar with the countless indescribable forms of the insects and
             flies, then I feel the presence of the Almighty, who formed us in
             his own image, and the breath of that universal love which bears
             and sustains us, as it floats around us in an eternity of bliss.",
             "One morning, when Gregor Samsa woke from troubled dreams, he found
             himself transformed in his bed into a horrible vermin. He lay on
             his armour-like back, and if he lifted his head a little he could
             see his brown belly, slightly domed and divided by arches into
             stiff sections. The bedding was hardly able to cover it and seemed
             ready to slide off any moment. His many legs, pitifully thin
             compared with the size of the rest of him, waved about helplessly
             as he looked. 'What's happened to me?' he thought. It wasn't a
             dream. His room, a proper human room although a little too small,
             lay peacefully between its four familiar walls. A collection of
             textile samples lay spread out on the table - Samsa was a
             travelling salesman - and above it there hung a picture that he had
             recently cut out of an illustrated magazine and housed in a nice,
             gilded frame. It showed a lady fitted out with a fur hat and fur
             boa who sat upright, raising a heavy fur muff that covered the
             whole of her lower arm towards the viewer. Gregor then turned to
             look out the window at the dull weather.",
             "The quick, brown fox jumps over a lazy dog. DJs flock by when MTV
             ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick
             quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox
             nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox.
             Bright vixens jump; dozy fowl quack. Quick wafting zephyrs vex bold
             Jim. Quick zephyrs blow, vexing daft Jim. Sex-charged fop blew my
             junk TV quiz. How quickly daft jumping zebras vex. Two driven jocks
             help fax my big quiz. Quick, Baz, get my woven flax jodhpurs! 'Now
             fax quiz Jack!' my brave ghost pled. Five quacking zephyrs jolt my
             wax bed. Flummoxed by job, kvetching W. zaps Iraq. Cozy sphinx
             waves quart jug of bad milk. A very bad quack might jinx zippy
             fowls. Few quips galvanized the mock jury box. Quick brown dogs
             jump over the lazy fox. The jay, pig, fox, zebra, and my wolves
             quack! Blowzy red vixens fight for a quick jump. Joaquin Phoenix
             was gazed by MTV for luck. A wizard’s job is to vex chumps quickly
             in fog. Watch 'Jeopardy!', Alex Trebek's fun TV quiz game. Woven
             silk pyjamas exchanged for blue quartz."]

  Travel.all.each.with_index(1) do |travel, cnt|
    print "\r   -> %d" % cnt
    [*0..5].sample.times do
      attributes = {
        :title   => titles.sample,
        :content => content.sample}
      travel.logs.create(attributes)
    end
  end
  puts "\r   -> %.4fs" % (Time.now - t_start)
  puts "== seeds.rb Log: seeded #{"(%.4fs)" % (Time.now - t_start)} ".ljust(79, "=")
  puts
end
