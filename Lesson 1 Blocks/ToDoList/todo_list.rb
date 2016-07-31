#
# class Todo:
#
class Todo
  DONE_MARKER = 'X'.freeze
  UNDONE_MARKER = ' '.freeze

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    raise TypeError, 'Can only add Todo objects' unless item.instance_of? Todo
    @todos << item
  end

  alias << add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    # raise IndexError, "No Todo object at index:#{index}" if !@todos[index]
    @todos.fetch(index) # fetch raises an exception thus re-use fetch all over!
  end

  def mark_done_at(index)
    # raise IndexError, "No Todo object at index:#{index}" if !@todos[index]
    # @todos[index].done!
    # @todos[index]
    item_at(index).done! # fetch will raise an error if the index is wrong.
  end

  def mark_undone_at(index)
    # if !@todos[index]
      # raise IndexError, "No Todo object at index:#{index} for method: mark_undone_at"
    # else
      # @todos[index].undone!
      # @todos[index]
    # end
    item_at(index).undone! # fetch will raise an error if the index is wrong.
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index)) # fetch will raise an error: in item_at().
    # @todos.delete_at(index)
    # raise IndexError, "remove_at(#{index})" unless @todos.delete_at(index)
  end

  # Todo_List_each:
  #
  # def each
  #   index = 0
  #   while index < @todos.size
  #     yield(@todos[index])
  #     index += 1
  #   end
  # end

  # def each
  #   @todos.each { |todo_item|  yield(todo_item) }
  #   self
  # end

  # Todo_List_select
  #
  # def select
  #   select_array = []
  #   @todos.each { |todo_item| select_array << todo_item if yield(todo_item) }
  #
  #   new_list = TodoList.new("Selected Todos:")
  #   select_array.each { |todo_item| new_list.add(todo_item) }
  #   new_list
  # end

  def find_by_title(string)
    select { |todo_item| todo_item.title == string }.first
    # selected_list = select { |todo_item| todo_item.title == string }
    # selected_list.first
  end

  def all_done_items
    select { |todo_item| todo_item.done? }
  end

  def all_not_done_items
    select { |todo_item| !todo_item.done? }
  end

  def mark_done(string)
    # select { |todo_item| todo_item.title == string }.first.done!
    find_by_title(string) && find_by_title(string).done!
  end

  def done!
    each { |todo_item| todo_item.done! }
  end

  def undone!
    each { |todo_item| todo_item.undone! }
  end

  def each
    @todos.each { |todo_item|  yield(todo_item) }
    self
  end

  def select
    new_list = TodoList.new("Selected Todos:")
    each { |todo_item| new_list.add(todo_item) if yield(todo_item) }
    new_list
  end

  def to_s
    todo_list_string = "ToDo List: \n"
    todo_list_string << @todos.map(&:to_s).join("\n")
    todo_list_string
  end

  def to_a
    @todos.each { |to_do_item| puts to_do_item }
  end
end

system("clear")

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos:")

# ---- Adding to the list -----
# add
puts "list.add:"
list.add(todo1)     # adds todo1 to end of list, returns list
list.add(todo2)     # adds todo2 to end of list, returns list
list.add(todo3)     # adds todo3 to end of list, returns list
# list.add(1)          # raises TypeError with message "Can only add Todo objects"
puts

# <<
# same behavior as add
todo4 = Todo.new("Do the dishes")
todo5 = Todo.new("Do the washing")
todo6 = Todo.new("Wash the floors")
todo7 = Todo.new("Put the garbage out")

list << todo4 << todo5 << todo6 << todo7
puts list
puts
# ---- Interrogating the list -----
# size
puts "The list contains #{list.size} Todo items."
puts

puts "Find by title:"
result = list.find_by_title("Do the washing")
puts result.inspect
puts

# mark_done_at
puts "list.mark_done_at(0, 2, 6):"
list.mark_done_at(0)            # marks the 2nd item as done
list.mark_done_at(2)            # marks the 2nd item as done
list.mark_done_at(6)            # marks the 2nd item as done
puts list
# list.mark_done_at(100)          # raises IndexError
puts

puts "Mark Done: 'Do the washinggg'"
list.mark_done("Do the washinggg")
puts

puts "All Done Items:"
result = list.all_done_items
puts result
puts

puts "All Not Done Items:"
result = list.all_not_done_items
puts result
puts

# first
puts "list.first:"
puts list.first        # returns todo1, which is the first item in the list
puts
# last
puts "list.last:"
puts list.last         # returns todo3, which is the last item in the list
puts
# ---- Retrieving an item in the list ----
# item_at
# list.item_at                  # raises ArgumentError
puts "list.item_at(2):"
puts list.item_at(2)          # returns 2nd item in list (zero based index)
# puts list.item_at(100)        # raises IndexError
puts

# mark_undone_at
# puts list.mark_undone_at        # raises ArgumentError
puts "list.mark_undone_at(1):"
list.mark_undone_at(1)          # marks the 2nd item as not done,
puts "list.mark_undone_at(2):"
list.mark_undone_at(2)          # marks the 2nd item as not done,
puts list
# list.mark_undone_at(100)        # raises IndexError
puts
# ---- Deleting from the the list -----
# to_s
puts "list.mark_done_at(0):"
list.mark_done_at(0)
puts list
puts

puts "list.mark_undone_at(0):"
list.mark_undone_at(0)
puts list
puts

# shift
puts "list.shift:"
puts list.shift             # removes and returns the first item in list
puts

# pop
puts "list.pop:"
puts list.pop             # removes and returns the last item in list
puts
puts "list:"
puts list
puts

# remove_at
puts "list.remove_at(1):"
# list.remove_at                  # raises ArgumentError
puts list.remove_at(1)            # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError
puts
puts list
puts

puts "list.mark_done_at(0):"
list.mark_done_at(0)
puts list
puts

puts "list.mark_undone_at(0):"
list.mark_undone_at(0)
puts list

puts
 # ---- Outputting the list -----
puts list
# "#{list}"
puts
# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym

puts "mark all done:"
list.done!
puts list
puts

puts "mark all undone:"
list.undone!
puts list
puts

puts "list.mark_done_at(1):"
list.mark_done_at(1)
puts list
puts

# .each
puts "list.each:"
list.each do |todo|
puts todo                   # calls Todo#to_s
end
puts

# The above should send each of the 3 `Todo` objects to `puts`, which will automatically invoke the `Todo#to_s` method. The output should be:

# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

puts "list.to_a:"
list.to_a
puts

puts "select:"
todo4.done!
# todo6.done!
# results = list.select { |todo| todo.done? } # you need to implement this
results = list.select(&:done?) # you need to implement this
puts results.inspect
puts

puts "Find by title:"
result = list.find_by_title("Do the washing")
puts result.inspect
puts
