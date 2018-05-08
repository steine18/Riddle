def get_numbers():
	number_list = [] # Create empty list to store correct answers
	for i in range(100000, 1000000):
		num = str(i)
		# Checks that the digits do not match and that ABC,CDE * 4 = EDC,CBA
		if num[0] not in num[1:] and num[1] not in num[2:] and num[2] not in num[4:] and num[4] != num[5] and num[2] == num[3] and i * 4 == int(str(i)[::-1]):
			number_list.append(i)
	return number_list

if __name__ == '__main__':
	print(get_numbers())
	