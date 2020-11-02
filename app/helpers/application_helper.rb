module ApplicationHelper

  def date_diff_string(dt)
    seconds_diff = (dt - Time.current).to_i.abs
    hours = seconds_diff / 3600
    if hours > 23
      return dt.strftime(t('layouts.post_list.short_date'))
    elsif hours == 0
      if seconds_diff < 60
        return t('layouts.post_list.now')
      else
        minutes = seconds_diff / 60
        if minutes == 1
          return t('layouts.post_list.one_minute')
        else
          return "#{minutes} #{t('layouts.post_list.minutes')}"
        end
      end
    elsif hours == 1
      return t('layouts.post_list.one_hour')
    else
      return "#{hours} #{t('layouts.post_list.hours')}"
    end
  end

  def accepted_user?(user)
  	
  	if user.locked
  		if current_user.id == user.id || Relationship.find_by(following_id: current_user.id, followed_id: user.id, accepted: true).present?
  			return true
  		else
  			return false
  		end
  	else
  		return true
  	end

  end

end
