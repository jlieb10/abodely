module ApartmentsHelper
	def apartment_path_helper(hunt, apartment)
		if hunt
			[:hunt, @apartment]
		else
			@apartment
		end
	end

  def render_details detail
    locals = {
      detail: detail,
    }

    case detail.procon
    when 'pro'
      locals[:klass] = 'pro-label'
    when 'con'
      locals[:klass] = 'con-label'
    else
      locals[:klass] = ''
    end
    render 'apartments/detail', locals
  end

  def temporary_image(count)
    if count == 0
      render 'apartments/nopics'
    end
  end

end
