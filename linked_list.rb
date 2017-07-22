require 'byebug'
require 'minitest/autorun'

class Node
  def initialize value=nil
    @next = nil
    @value = value
  end

  def value
    @value
  end

  def next
    @next
  end

  def next= node
    @next = node
  end
end

class List
  def initialize
    @head = nil
    @tail = nil
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def push node
    # if tail is nil, list is empty
    if @tail.nil?
      @head = node
      @tail = node
    else
      # list is not empty, add node to tail
      @tail.next = node
      @tail = node
    end
  end

  def pop
    return nil if @head == nil
    tail_node = @tail
    current = @head
    while current.next.next != nil
      current = current.next
    end
    @tail = current
    @tail.next = nil
    tail_node
  end

  def shift
    return nil if @head == nil
    head_node = @head
    @head = @head.next
    head_node
  end

  def unshift node
    node.next = @head
    @head = node
  end

  def head
    @head
  end
end

class ListTest < Minitest::Test
  def setup
    @first_node = Node.new "first_node"
    @second_node = Node.new "second_node"
    @third_node = Node.new "third_node"
    @list = List.new
  end

  def test_create_empty_list
    assert_nil @list.head
    assert_nil @list.tail
  end

  def test_push
    @list.push @first_node
    assert_equal @first_node, @list.head
    assert_equal @first_node, @list.tail

    @list.push @second_node
    assert_equal @first_node, @list.head
    assert_equal @second_node, @list.tail
  end

  def test_pop
    assert_nil @list.pop
    @list.push @first_node
    @list.push @second_node
    @list.push @third_node
    node = @list.pop
    assert_equal @third_node, node
    assert_equal @second_node, @list.tail
    assert_equal @first_node, @list.head
    assert_equal @second_node, @first_node.next
  end

  def test_shift
    assert_nil @list.shift
    @list.push @first_node
    @list.push @second_node
    @list.shift
    assert_equal @second_node, @list.head
  end

  def test_unshift
    @list.unshift @second_node
    assert_equal @second_node, @list.head
    @list.unshift @first_node
    assert_equal @first_node, @list.head
  end
end

class NodeTest < Minitest::Test
  def test_creation
    value = "asdf"
    node = Node.new(value)
    assert_equal value, node.value
  end

  def test_default_nil_value
    node = Node.new
    assert_nil node.value
  end
end

