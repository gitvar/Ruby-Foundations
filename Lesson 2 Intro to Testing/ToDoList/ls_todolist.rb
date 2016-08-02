# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
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

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end
  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def undone!
    @todos.each_index do |idx|
      mark_undone_at(idx)
    end
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("ToDo List:")

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

# # ---- Marking items in the list -----
# mark_done_at
# list.mark_done_at               # raises ArgumentError
puts "list.mark_done_at(2):"
list.mark_done_at(2)            # marks the 2nd item as done
puts list
# list.mark_done_at(100)          # raises IndexError
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
puts list.shift           # removes and returns the first item in list
puts

# pop
puts "list.pop:"
puts list.pop                        # removes and returns the last item in list
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



# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)
# list.add(1)         # raises TypeError with message "Can only add Todo objects"
# puts list
#
# list.pop
#
# puts list
#
# list.mark_done_at(1)
#
# puts list
