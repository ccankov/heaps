require_relative "heap"

class Array
  def heap_sort!
    max_prc = proc { |el1, el2| -1 * (el1 <=> el2) }
    heap_end_idx = 0
    until heap_end_idx == length
      BinaryMinHeap.heapify_up(
        self, heap_end_idx, heap_end_idx + 1, &max_prc
      )
      heap_end_idx += 1
    end

    until heap_end_idx == 0
      self[0], self[heap_end_idx - 1] = self[heap_end_idx - 1], self[0]
      heap_end_idx -= 1
      BinaryMinHeap.heapify_down(
        self, 0, heap_end_idx, &max_prc
      )
    end
  end
end
