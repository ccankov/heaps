require_relative 'heap'

def k_largest_elements(array, k)
  max_prc = proc { |el1, el2| -1 * (el1 <=> el2) }
  heap_end_idx = 0

  until heap_end_idx == array.length
    BinaryMinHeap.heapify_up(
      array, heap_end_idx, heap_end_idx + 1, &max_prc
    )
    heap_end_idx += 1
  end

  until heap_end_idx == array.length - k
    array[0], array[heap_end_idx - 1] = array[heap_end_idx - 1], array[0]
    heap_end_idx -= 1
    BinaryMinHeap.heapify_down(
      array, 0, heap_end_idx, &max_prc
    )
  end

  array[-k..-1]
end
