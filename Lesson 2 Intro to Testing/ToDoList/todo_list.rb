# class Todo:

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
    @todos.fetch(index) # fetch raises an exception thus re-use fetch all over!
  end

  def mark_done_at(index)
    item_at(index).done! # fetch will raise an error if the index is wrong.
  end

  def mark_undone_at(index)
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
  end

  def find_by_title(string)
    select { |todo_item| todo_item.title == string }.first
  end

  def all_done_items
    select { |todo_item| todo_item.done? }
  end

  def all_not_done_items
    select { |todo_item| !todo_item.done? }
  end

  def mark_done(string)
    find_by_title(string) && find_by_title(string).done!
  end

  def done?
    @todos.all? { |todo_item| todo_item.done? }
  end

  def not_done?
    @todos.all? { |todo_item| !todo_item.done? }
  end

  def done!
    @todos.each_index { |index| mark_done_at(index) }
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
