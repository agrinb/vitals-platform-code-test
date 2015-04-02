require 'award'


def update_quality(awards)
  awards.each do |award|
    if common_award(award) &&  award.quality > 0
        check_blue_ditinction(award)
    else
      blue_compare_and_first(award)
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end

    if award.expires_in < 0
      expired_award(award)
    end
    adjust_blue_star(award)
  end
end

def adjust_blue_compare(award)
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

def check_blue_ditinction(award)
  if award.name != 'Blue Distinction Plus'
      award.quality -= 1
  end
end

def blue_compare_and_first(award)
  if award.quality < 50
    award.quality += 1
    adjust_blue_compare(award)
  end
end

def expired_award(award)
  if award.name != 'Blue First'
    if award.name != 'Blue Compare'
      if award.quality > 0
        check_blue_ditinction(award)
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

def common_award(award)
  award.name != 'Blue First' && award.name != 'Blue Compare'
end

def adjust_blue_star(award)
  if award.name == 'Blue Star'
    if award.quality < 50
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