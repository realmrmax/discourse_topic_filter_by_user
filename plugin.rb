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
  

#end

after_initialize do
  require_dependency 'topic_query'
  require_dependency 'application_controller'

	# class ApplicationController < ActionController::Base
		# before_filter :determine_website

		# private
		# def determine_website
			# sitename = request.fullpath
			Rails.logger.warn("#{params[:controller]}")

		# end

	# end
	  
	  #Rails.logger.warn("#{ApplicationController.request.fullpath}")
		#Rails.logger.warn("#{request_new.fullpath}")
	#end
		TopicQuery.add_custom_filter(:kb) do |results, latest|

			results = results.where("topics.user_id NOT IN (1,-1)")
		
		end  
	
  
end


# after_initialize do
  # require_dependency 'topic_query'
  # require_dependency 'categories_controller'
  
		# # TopicQuery.add_custom_filter(:kb) do |results, latest|

			# # results = results.where("topics.user_id NOT IN (1,-1)")
		
		# # end
	  # # if TopicQuery.respond_to?(:results_filter_callbacks)
		# # remove_muted_for_lists = [:latest, :new]
		# # remove_muted_tags = Proc.new do |list_type, result, user, options|

			# # muted_tags = DiscourseTagging.muted_tags(user)
				# # result.where("topics.user_id NOT IN (1,-1)")
	  # # end

		# # TopicQuery.results_filter_callbacks << remove_muted_tags
	  # # end		

		# class CategoriesController
		
				# def categories_and_latest
					# categories_and_topics(:kb)
				# end
			
			  # def categories_and_topics(topics_filter)
				# discourse_expires_in 1.minute

				# category_options = {
				  # is_homepage: current_homepage == "categories",
				  # parent_category_id: params[:parent_category_id],
				  # include_topics: false
				# }

				# topic_options = {
				  # per_page: CategoriesController.topics_per_page,
				  # no_definitions: true
				# }

				# result = CategoryAndTopicLists.new
				# result.category_list = CategoryList.new(guardian, category_options)

				# if topics_filter == :latest
				  # result.topic_list = TopicQuery.new(current_user, topic_options).list_latest
				# elsif topics_filter == :kb
				  # result.topic_list = TopicQuery.new(current_user, topic_options).list_kb
				# elsif topics_filter == :top
				  # result.topic_list = TopicQuery.new(nil, topic_options).list_top_for(SiteSetting.top_page_default_timeframe.to_sym)
				# end

				# draft_key = Draft::NEW_TOPIC
				# draft_sequence = DraftSequence.current(current_user, draft_key)
				# draft = Draft.get(current_user, draft_key, draft_sequence) if current_user

				# %w{category topic}.each do |type|
				  # result.public_send(:"#{type}_list").draft = draft
				  # result.public_send(:"#{type}_list").draft_key = draft_key
				  # result.public_send(:"#{type}_list").draft_sequence = draft_sequence
				# end

				# render_serialized(result, CategoryAndTopicListsSerializer, root: false)
			  # end			


			  # def index
				# discourse_expires_in 1.minute

				# @description = SiteSetting.site_description

				# parent_category = Category.find_by_slug(params[:parent_category_id]) || Category.find_by(id: params[:parent_category_id].to_i)

				# category_options = {
				  # is_homepage: current_homepage == "categories",
				  # parent_category_id: params[:parent_category_id],
				  # include_topics: include_topics(parent_category)
				# }

				# @category_list = CategoryList.new(guardian, category_options)
				# @category_list.draft_key = Draft::NEW_TOPIC
				# @category_list.draft_sequence = DraftSequence.current(
				  # current_user,
				  # Draft::NEW_TOPIC
				# )
				# @category_list.draft = Draft.get(current_user, Draft::NEW_TOPIC, @category_list.draft_sequence) if current_user

				# if category_options[:is_homepage] && SiteSetting.short_site_description.present?
				  # @title = "#{SiteSetting.title} - #{SiteSetting.short_site_description}"
				# elsif !category_options[:is_homepage]
				  # @title = "#{I18n.t('js.filters.categories.title')} - #{SiteSetting.title}"
				# end

				# respond_to do |format|
				  # format.html do
					# store_preloaded(@category_list.preload_key, MultiJson.dump(CategoryListSerializer.new(@category_list, scope: guardian)))

					# style = SiteSetting.desktop_category_page_style
					# topic_options = {
					  # per_page: CategoriesController.topics_per_page,
					  # no_definitions: true
					# }

					# if style == "categories_and_latest_topics"
					  # @topic_list = TopicQuery.new(current_user, topic_options).list_kb
					  # @topic_list.more_topics_url = url_for(public_send("latest_path"))
					# elsif style == "categories_and_top_topics"
					  # @topic_list = TopicQuery.new(nil, topic_options).list_top_for(SiteSetting.top_page_default_timeframe.to_sym)
					  # @topic_list.more_topics_url = url_for(public_send("top_path"))
					# end

					# if @topic_list.present? && @topic_list.topics.present?
					  # store_preloaded(
						# @topic_list.preload_key,
						# MultiJson.dump(TopicListSerializer.new(@topic_list, scope: guardian))
					  # )
					# end

					# render
				  # end

				  # format.json { render_serialized(@category_list, CategoryListSerializer) }
				# end
			  # end


		# end
		
 		# class TopicQuery

			  # def list_kb
				# create_list(:kb, {}, latest_kb_results)
			  # end			
			
			  # def latest_kb_results(options = {})
				# result = default_results(options)
				# result = remove_muted_topics(result, @user) unless options && options[:state] == "muted"
				# result = remove_muted_categories(result, @user, exclude: options[:category])
				# result = remove_muted_tags(result, @user, options)
				# result = apply_shared_drafts(result, get_category_id(options[:category]), options)
				# result.where("topics.user_id NOT IN (1,-1)") 

				# result
			  # end			

		# end
# end