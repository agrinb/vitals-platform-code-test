require 'award'

def update_quality(awards)
  awards.each do |award|
    check_blue_first_or_compare(award)
    check_blue_distict_plus(award)
    check_blue_star(award)
  end
end

def check_blue_compare(award)
  if award.name == 'Blue Compare'
    if award.expires_in < 11
      if award.quality < 50
        award.quality += 1
      end
    end
    if award.expires_in < 6
      if award.quality < 50
        award.quality += 1
      end
    end
  end
end

def check_blue_star(award)
  if award.name == 'Blue Star'
    if award.quality < 50
      if award.name == 'Blue Star'
        if award.expires_in < 6
          if award.quality < 50
            unless (award.quality - 2) < 0
              award.quality -= 1
            end
          end
        end
        if award.expires_in < 0
          if award.quality < 50
            unless (award.quality - 1) < 0
              award.quality -= 1
            end
          end
        end   
      end
    end
  end
end

def check_blue_first_or_compare(award)
  if award.name != 'Blue First' && award.name != 'Blue Compare'
    if award.quality > 0
      if award.name != 'Blue Distinction Plus'
        award.quality -= 1
      end
    end
  else
    if award.quality < 50
      award.quality += 1
      check_blue_compare(award)
    end
  end
end

def check_blue_distict_plus(award)
  if award.name != 'Blue Distinction Plus'
    award.expires_in -= 1
  end
  if award.expires_in < 0
    if award.name != 'Blue First'
      if award.name != 'Blue Compare'
        if award.quality > 0
          if award.name != 'Blue Distinction Plus'
            award.quality -= 1
          end
        end
      else
        award.quality = award.quality - award.quality
      end
    else
      if award.quality < 50
        award.quality += 1
      end
    end
  end
end