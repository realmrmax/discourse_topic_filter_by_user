# name: discourse_topic_filter_by_user
# about: Show latest filtered by user
# version: 0.1
# authors: Maxym Khaykin
# url: https://github.com/realmrmax/discourse_topic_filter_by_user

#after_initialize do
  # require_dependency 'topic_query'
  # require_dependency 'application_controller'

  # if TopicQuery.respond_to?(:results_filter_callbacks)
    # remove_muted_for_lists = [:latest, :new]
    # remove_muted_tags = Proc.new do |list_type, result, user, options|

        # muted_tags = DiscourseTagging.muted_tags(user)
		# #if  request.referer =~ /\// || request.referer =~ /\/categories\//
            # result.where("topics.user_id NOT IN (1,-1)")
		# #end
		# #Rails.logger.warn("#{Discourse.base_uri}")
    # end

    # TopicQuery.results_filter_callbacks << remove_muted_tags
  # end
  
# end

after_initialize do
  require_dependency 'topic_query'
  require_dependency 'categories_controller'
  
		TopicQuery.add_custom_filter(:kb) do |results, latest|

			results = results.where("topics.user_id NOT IN (1,-1)")
		
		end
		
		class ::Categories_controller
			module TopicFilter
				def categories_and_latest
					categories_and_topics(:kb)
				end
			end
			prepend TopicFilter
		end
 
end