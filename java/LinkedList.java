public class LinkedList<E> implements Queue<E> {

  private int size = 0;
  /**
   * Pointer to first node. Invariant: (first == null && last == null) || (first.prev == null && first.item != null)
   */
  private Node<E> first;
  /**
   * Pointer to last node. Invariant: (first == null && last == null) || (last.next == null && last.item != null)
   */
  private Node<E> last;

  /**
   * Constructs an empty list.
   */
  public LinkedList() {
  }

  /**
   * Links e as last element.
   */
  private void linkLast(E e) {
    final Node<E> l = last;
    final Node<E> newNode = new Node<E>(l, e, null);
    last = newNode;
    if (l == null) {
      first = newNode;
    } else {
      l.next = newNode;
    }
    size++;
  }

  /**
   * Unlinks non-null first node f.
   */
  private E unlinkFirst(Node<E> f) {
    // assert f == first && f != null;
    final E element = f.item;
    final Node<E> next = f.next;
    f.item = null;
    f.next = null; // help GC
    first = next;
    if (next == null) {
      last = null;
    } else {
      next.prev = null;
    }
    size--;
    return element;
  }

  /**
   * Retrieves, but does not remove, the head (first element) of this list.
   *
   * @return the head of this list, or {@code null} if this list is empty
   * @since 1.5
   */
  public E peek() {
    final Node<E> f = first;
    return (f == null) ? null : f.item;
  }

  /**
   * Retrieves and removes the head (first element) of this list.
   *
   * @return the head of this list, or {@code null} if this list is empty
   * @since 1.5
   */
  public E poll() {
    final Node<E> f = first;
    return (f == null) ? null : unlinkFirst(f);
  }

  /**
   * Adds the specified element as the tail (last element) of this list.
   *
   * @param e the element to add
   * @return {@code true} (as specified by {@link Queue#offer})
   * @since 1.5
   */
  public boolean offer(E e) {
    linkLast(e);
    return true;
  }

  private static class Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;

    Node(Node<E> prev, E element, Node<E> next) {
      this.item = element;
      this.next = next;
      this.prev = prev;
    }
  }
}
