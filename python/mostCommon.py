# looks fine but definitely needs some unittests.
def mostCommon(array):
	""" Given a set of elements of size N with an element that appears at least N/2 times,
	tells which element is the most frequent by looping only one time over 
	the array and by using a single counter in memory.
	"""
	# empty set, no match
	if len(array) == 0:
		return False
	# init of the counter and the candidate
	counter = 0
	candidate = array[0]
	for el in array:
		if el == candidate:
			# the candidate was found, increment the counter
			counter += 1
		else:
			# the candidate wasn't found, decrement the counter
			counter -= 1
			if counter < 0:
				# the counter is negative, we know our candidate is'nt the right one
				# let's make the current element the new candidate and reinit the counter to 1 match
				candidate = el
				counter = 1
		# print counter, el, candidate
	return candidate;


if __name__ == '__main__':
	s = [1,1,2,2,2,2,4,2,1,6]
	print 'most common element in', s, 'is', mostCommon(s)
