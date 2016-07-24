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
  require 'pry'
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation

  def add(todo_item)
    if todo_item.instance_of?(Todo)
      @todos << todo_item
    else
      puts "TypeError: Can only add ToDo objects."
    end
  end

  def <<(todo_item)
    add(todo_item)
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

  def item_at(index)
    if !@todos[index]
      "Index error - item_at()"
    else
      @todos[index]
    end
  end

  def mark_done_at(index)
    if !@todos[index]
      puts "Index error! - mark_done_at(#{index})"
    else
      @todos[index].done!
      @todos[index]
    end
  end

  def mark_undone_at(index)
    if !@todos[index]
      puts "Index error! - mark_undone_at(#{index})"
    else
      @todos[index].undone!
      @todos[index]
    end
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if !@todos[index]
      puts "Index error! - remove_at(#{index})"
    else
      @todos.delete_at(index)
    end
  end

  def to_s
    @todos.each { |to_do_item| puts to_do_item }
  end
end

system("clear")

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----
# add
list.add(todo1)     # adds todo1 to end of list, returns list
list.add(todo2)     # adds todo2 to end of list, returns list
list.add(todo3)     # adds todo3 to end of list, returns list
list.add(1)         # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add
todo4 = Todo.new("Do the dishes")
list << todo4

# ---- Interrogating the list -----
# size
puts
puts list.size                       # returns 3

# # first
puts list.first        # returns todo1, which is the first item in the list
#
# last
puts list.last         # returns todo3, which is the last item in the list
puts
# ---- Retrieving an item in the list ----
# item_at
# list.item_at       # raises ArgumentError
puts list.item_at(1)    # returns 2nd item in list (zero based index)
puts list.item_at(100)  # raises IndexError
puts

# # ---- Marking items in the list -----
# mark_done_at
# list.mark_done_at               # raises ArgumentError
list.mark_done_at(1)            # marks the 2nd item as done
list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# puts list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done,
list.mark_undone_at(100)        # raises IndexError

# ---- Deleting from the the list -----
# to_s
puts
list.mark_done_at(0)
list.to_s

puts
list.mark_undone_at(0)
list.to_s
puts

# shift
puts "list.shift:"
puts list.shift                      # removes and returns the first item in list

# pop
puts "list.pop:"
puts list.pop                        # removes and returns the last item in list
puts
list.to_s
puts

# remove_at
puts "list.remove_at:"
# list.remove_at                  # raises ArgumentError
list.remove_at(1)               # removes and returns the 2nd item
list.remove_at(100)             # raises IndexError

 # ---- Outputting the list -----
list.to_s
puts

list.mark_undone_at(0)
list.to_s

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym
