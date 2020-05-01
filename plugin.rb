# name: discourse_topic_filter_by_user
# about: Show latest filtered by user
# version: 0.1
# authors: Maxym Khaykin
# url: https://github.com/realmrmax/discourse_topic_filter_by_user

after_initialize do
  require_dependency 'topic_query'

		TopicQuery.add_custom_filter(:kb) do |results, topic_query|

			results = results.where("topics.user_id <> 1")
		
		end
 
end
