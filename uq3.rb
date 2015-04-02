require 'award'

def update_quality(awards)
  awards.each do |award|
    if common_award(award)
      dec_quality(award)  
    else
      if award.quality < 50
        add_quality(award)
        add_to_blue_compare(award)
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    expired(award)
    adjust_blue_star(award)
  end
end

def expired(award)
  if award.expires_in < 0
    if award.name != 'Blue First'
      if award.name != 'Blue Compare'
        dec_quality(award)
      else
        award.quality = 0
      end
    else
      add_quality(award)
    end
  end
end

def add_quality(award)
  if award.quality < 50
    award.quality += 1
  end
end

def add_to_blue_compare(award)
  if award.name == 'Blue Compare'
    if award.expires_in < 11
      add_quality(award)
    end
    if award.expires_in < 6
      add_quality(award)
    end
  end
end

def common_award(award)
  award.name != 'Blue First' && award.name != 'Blue Compare'
end

def dec_quality(award)
  if award.quality > 0
    if award.name != 'Blue Distinction Plus'
      award.quality -= 1
    end
  end
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