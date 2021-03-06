module FrontHelper
  def render_type(e)
    if e.event_type == "itemLoot" or e.event_type == "itemCraft"
      content_tag(:a, '', href: "http://www.wowhead.com/item=#{e.itemId}")
    elsif e.event_type == "playerAchievement" or e.event_type="guildAchievement"
      content_tag(:a, '', href: "http://wotlk.wowhead.com/achievement=#{e.achievementId}")
    else
      e.event_type
    end
  end

  def render_log_link
    url = Rails.application.config.combat_logs_url
    if url != nil
      content_tag(:a, 'View Logs', href: url)
    end
  end

  def realm
    Rails.application.config.realm
  end

  def allegiance
    g = Guild.find_by(name: Rails.application.config.guild_name)
    if g != nil && g.side == 1
      content_tag(:div, 'Horde Guild', class: "guild-side horde")
    else
      content_tag(:div, 'Aliiance Guild', class: "guild-side alliance")
    end
  end

  def render_label(member)
    c = member.reports_count
    if c > 0 && member.reports_new
      link_to content_tag(:span, c, class: "label label-info"), member
    else
      link_to content_tag(:span, c, class: "label label-default"), member
    end
  end

  def display_time(time)
    if time <= Time.now
      "#{time_ago_in_words(time)} ago"
    else
      "#{time_ago_in_words(time)} from now"
    end
  end

end
