# array = Map with acending integer as Key with fixed size
# Use when:
# * no special keys needed
# * duplicates allowed
# * fixed size is no problem (when it is see List)
array = [ "First Text", "Last Text", "I shall be deleted" ]
array = array[:len(array)-1] #Remove last item

# list = array with dynamic size
list = []
list.append("First Text")
list.append("Last Text")

# map = key-value-pair = lookup-table = dictionary
map = { "Key1": "First Text", "Key2": "Second Text" }
map["Key"] = "Last Text"

i = 0
while i in range(len(array)):
	print(array[i])
	i += 1

# for
for i in range(len(list)):
	print(list[i])


# for-in
# we get the key because a map is key driven
for key in map:
	print("map[",key,"] -> ", map[key])
