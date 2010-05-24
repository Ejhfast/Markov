require 'pp'

intxt = File.new(ARGV[0],"r").to_a.join(" ")
words = intxt.split(" ")
sz = words.size
pairs = words.each_index.map do |x|
	if not (x == sz - 1)
		[words[x], words[x+1]]
	end
end

def lookup(wrd, pairs)
	matching = pairs.select{|x| x and x[0] == wrd}
	matching.map{|x| x.last}
end

def weighted_choice(arry)
	counter = Hash.new(0)
	total = 0
	selected = nil
	arry.each do |x|
		counter[x] = counter[x] + 1
		total = total + 1
	end
	with_w = arry.map{|x| [x] + [counter[x]]}
	choice = rand(total)
	upto = 0
	with_w.each_index do |x|
		if choice < (upto + with_w[x].last)
			selected = with_w[x].first
			break
		else
			upto = upto + with_w[x].last
		end
	end
	selected
end

def run(pairs)
	#select initial word randomly
	sz = pairs.size - 1
	sel = rand(sz)
	current = pairs[sel].first


	#iterate over a sentence
	outp = current + " "
	while current[current.size-1] != "." do
		gd = (lookup current, pairs)
		current = weighted_choice gd
		outp = outp + current + " "
	end
	puts
	puts outp
end

(0..100).each {run pairs}

	
