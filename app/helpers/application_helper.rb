module ApplicationHelper

	def abodely_bookmarklet
		if Rails.env.development?
    	easymarklet_js('bookmarkletDev.js')
    else
    	easymarklet_js('bookmarklet.js')
    end
	end
end



		# item.match(/-[a-f0-9]{32}/)
		# check names of all javascript files
		# if they match bookmarklet and regex
		# gsub out the regex
