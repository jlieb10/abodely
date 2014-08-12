module ApplicationHelper

	def abodely_bookmarklet
		if Rails.env.development?
    	easymarklet_js('bookmarkletDev')
    else
    	easymarklet_js('bookmarklet')
    end
	end
end