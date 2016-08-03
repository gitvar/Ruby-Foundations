require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos_array = [@todo1, @todo2, @todo3]

    @list = TodoList.new("---- Today's Todos ----")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos_array, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_not_done?
    assert_equal(true, @list.not_done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list << "Hello World!" }
    assert_raises(TypeError) { @list << 25 }
    assert_raises(TypeError) { @list << [23, "hi"] }
    # assert_raises(TypeError) { @list << Todo.new("Put the garbage out") }
  end

  def test_add_alais
    # assert(@list << Todo.new("Put the garbage out"))
    puts
    puts "test_add_alais::"
    puts
    new_todo = Todo.new("Put the garbage out")
    @list.add(new_todo)
    puts "@list::"
    puts @list

    todo_array = @todos_array << new_todo
    puts "todo_array::"
    puts todo_array
    puts

    assert_equal(todo_array, @list.to_a)
  end

# 10. item_at(index) - should raise an Indexerror!
  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo3, @list.item_at(2))
    assert_raises(IndexError) { @list.item_at(1000) }
  end

# 11. mark_done_at(index) - should raise an Indexerror!
  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)

    assert_equal(false, @list.item_at(1).done?)
    assert_equal(true, @list.item_at(1).not_done?)

    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)

    assert_raises(IndexError) { @list.mark_done_at(1000) }
  end

# 12. mark_undone_at(index) - should raise an Indexerror!
  def test_mark_udone_at
    # Setup, Execute and Assert Pre-Condition (mark @todo1 done):
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)

    # Setup, Execute and Assert (mark @todo1 undone and assert the not_done):
    @list.mark_undone_at(0)
    assert_equal(true, @todo1.not_done?)
    assert_equal(false, @todo1.done?)

    assert_raises (IndexError) { @list.mark_undone_at(1000) }
  end

# 13. done!
  def test_done!
    @list.done!

    assert_equal(true, @list.done?)
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

# 14. remove_at(index) - should raise an Indexerror!
  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }

    @list.remove_at(2)
    @list.remove_at(1)
    @list.remove_at(0)

    3.times { |n| assert_raises(IndexError) { @list.item_at(n) } }

    assert_equal([], @list.to_a)
  end

# 15. to_s : LS gave this answer - via HEREDOC:
  def test_to_s_1
    output = <<-OUTPUT.chomp.gsub (/^\s+/), ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

# 16. to_s: Return with one of the todo's done:
  def test_to_s_2
    output = <<-OUTPUT.chomp.gsub (/^\s+/), ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

# 17. to_s: Return with one of the todo's done:
  def test_to_s_3
    output = <<-OUTPUT.chomp.gsub (/^\s+/), ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

# 18. each:
  def test_each
    test_array = []
    @list.each { |item| test_array << item }

    assert_equal(@todos_array, test_array)
  end

# 19. each to return original object.
  def test_each_return_object
    # assert_instance_of(TodoList, @list.each {})
    assert_equal(@list, @list.each { |item| nil })
  end

#20. select:
  def test_select_1
    @list.mark_done_at(0)
    @list.mark_done_at(2)
    select_list = @list.select { |item| item.done? }
    select_list.title = "---- Today's Todos ----"

    assert_equal(@list.title, select_list.title)
    assert_equal([@todo1, @todo3], select_list.to_a)
  end

  def test_select_2
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end
