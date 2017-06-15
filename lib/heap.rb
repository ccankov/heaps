class BinaryMinHeap
  attr_reader :store, :prc

  @@prc = proc { |el1, el2| el1 <=> el2 }

  def initialize(&prc)
    @store = []
    @prc ||= @@prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[@store.length - 1] = @store[@store.length - 1], @store[0]
    val = @store.pop
    @store = self.class.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    @store = self.class.heapify_up(@store, @store.length - 1, @store.length, &@prc)
  end

  public

  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select { |el| el < len}
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index.zero?
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= @@prc
    parent_val = array[parent_idx]
    children_idx = child_indices(len, parent_idx)
    min_child_idx = children_idx.min do |el1, el2|
      prc.call(array[el1], array[el2])
    end

    if !children_idx.empty? && prc.call(array[min_child_idx], parent_val) < 0
      array[min_child_idx], array[parent_idx] = array[parent_idx], array[min_child_idx]
      heapify_down(array, min_child_idx, len, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx.zero?
    prc ||= @@prc
    child_val = array[child_idx]
    parent_idx = parent_index(child_idx)

    if prc.call(array[parent_idx], child_val) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end
