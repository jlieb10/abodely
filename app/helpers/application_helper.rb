module ApplicationHelper

	def abodely_bookmarklet
		if Rails.env.development?
    	easymarklet_js("..#{javascript_path 'bookmarkletDev'}")
    else
    	easymarklet_js("javascript_path 'bookmarklet")
    end
	end
end