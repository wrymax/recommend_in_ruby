# encoding: utf-8
# TODO:
# 	1. add Pearson dist
# 	2. support recommendation based on configurable dist methods
# 	3. modulize the methods
# 	4. Think about data saving structure, for fast search
# 	5. Think of how to quickly search recommendations
# 	6. put it into production
require 'json'

# 4 => invest
# 3 => meet
# 2 => like
# 2 => follow
# 1 => browse
# 0 => no interest

scores = {
	'Michael' => {
		"创投圈" => 5, 
		"嘀嘀打车" => 4, 
		"陌陌" => 1, 
		"蚁视科技" => 5, 
		"Teambition" => 3
	}, 
	'Fan' => {
		"创投圈" => 5, 
		"嘀嘀打车" => 3, 
		"陌陌" => 0, 
		"蚁视科技" => 4, 
		"Teambition" => 2
	}, 
	'Max' => {
		"创投圈" => 5, 
		"嘀嘀打车" => 5, 
		"陌陌" => 4, 
		"蚁视科技" => 0, 
		"Teambition" => 2
	}, 
	'郑刚' => {
		"创投圈" => 2, 
		"嘀嘀打车" => 4, 
		"陌陌" => 5, 
		"蚁视科技" => 0, 
		"Teambition" => 0
	}, 
	'徐小平' => {
		"创投圈" => 5, 
		"嘀嘀打车" => 0, 
		"陌陌" => 0, 
		"蚁视科技" => 4, 
		"Teambition" => 1
	}, 
	"雷军" => {
		"创投圈" => 4, 
		"嘀嘀打车" => 1, 
		"陌陌" => 0, 
		"蚁视科技" => 5, 
		"Teambition" => 2
	}, 
	'邓峰' => {
		"创投圈" => 1, 
		"嘀嘀打车" => 3, 
		"陌陌" => 1, 
		"蚁视科技" => 5, 
		"Teambition" => 4
	} 
}

object = ARGV[0]
raise "#{object} does not exist." unless scores[object]
# 
# target = ARGV[1]
# raise "#{target} does not exist." unless scores[target]

def euclidean_dist(data_set, object, target)
	common_startups = data_set[object].keys and data_set[target].keys
	return 0 if common_startups.empty?

	pows = common_startups.map do |startup|
		(data_set[object][startup] - data_set[target][startup]) ** 2
	end
	1.0 / (1 + (Math.sqrt pows.inject(0){ |v,  i| i += v  }))
end

# p "#{object} ~ #{target}: " 
# p euclidean_dist(scores, object, target)

def recommend_investor(data_set, object)
	# use euclidean_dist
	results = (data_set.keys.dup - [object]).inject([]) do |arr, target|
		arr.push [target, euclidean_dist(data_set, object, target)]
	end
	results.sort{ |x, y| y[1] <=> x[1] }
end

ret = recommend_investor(scores, 'Michael')
puts ret.map{|x| "#{x[0]}: #{x[1]}"}.join("; ")
