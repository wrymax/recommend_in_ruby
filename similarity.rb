# Similarity methods
# encoding: utf-8

load 'lib/helpers.rb'
include Helpers

module Similarity
	def euclidean_dist(data_set, object, target)
		common_startups = data_set[object].keys and data_set[target].keys
		return 0 if common_startups.empty?

		pows = common_startups.map do |startup|
			(data_set[object][startup] - data_set[target][startup]) ** 2
		end
		1.0 / (1 + (Math.sqrt pows.inject(0){ |v,  i| i += v  }))
	end

	def pearson_dist(data_set, object, target)
		common_startups = data_set[object].keys and data_set[target].keys
		return 0 if common_startups.empty?

		n = common_startups.length
		
		# 1. sum(object), sum(target)
		sum_obj = sum(common_startups.map{ |s| data_set[object][s] })
		sum_target = sum(common_startups.map{ |s| data_set[target][s] })

		# 2. sum up the squares of object and target
		sum_obj_sq = sum(common_startups.map{ |s| data_set[object][s] ** 2 })
		sum_target_sq = sum(common_startups.map{ |s| data_set[target][s] ** 2 })

		# sum up multiplies in object and target
		m_sum = sum(common_startups.map{ |s| data_set[object][s] * data_set[target][s] })

		num = m_sum - (sum_obj * sum_target / n)
		den = Math.sqrt((sum_obj_sq - (sum_obj ** 2)/n) * (sum_target_sq-(sum_target ** 2)/n))

		return 0 if den == 0

		num / den
	end
end
