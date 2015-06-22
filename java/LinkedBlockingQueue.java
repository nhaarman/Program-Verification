public class LinkedBlockingQueue<E> extends AbstractQueue<E>  implements BlockingQueue<E> {

  static class Node<E> {
    /** The item, volatile to ensure barrier separating write and read */
    volatile E item;
    Node<E> next;
    Node(E x) { item = x; }
  }

  /** The capacity bound, or Integer.MAX_VALUE if none */
  private final int capacity;

  /** Current number of elements */
  private final AtomicInteger count = new AtomicInteger(0);

  /** Head of linked list */
  private transient Node<E> last;

  /** Lock held by take, poll, etc */
  private final ReentrantLock takeLock = new ReentrantLock();

  /** Wait queue for waiting takes */
  private final Condition notEmpty = takeLock.newCondition();

  /** Wait queue for waiting puts */
  private final Condition notFull = putLock.newCondition();

  /**
   * Signals a waiting take. Called only from put/offer (which do not
   * otherwise ordinarily lock takelock.)
   */
  private void signalNotEmpty() {
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lock();
    try {
      notEmpty.signal();
    } finally {
      takeLock.unlock();
    }
  }

  /**
   * Signals a waiting put. Called only from take/poll.
   */
  private void signaleNotFull() {
    final ReentrantLock putLock = this.putLock;
    putLock.lock();
    try {
      notFull.signal();
    } finally {
      putLock.unlock();
    }
  }

  /**
   * Creates a node and links it at end of queue.
   * @param x the item
   */
  private void insert(E x) {
    last = last.next = new Node<E>(x);
  }

  /**
   * Removes a node from head of queue.
   * @return the node
   */
  private E extract() {
    Node<E> first = head.next;
    head = first;
    E x = first.item;
    first.item = null;
    return x;
  }

  /**
   * Lock to prevent both puts and takes.
   */
  private void fullyLock() {
    putLock.lock();
    takeLock.lock();
  }

  /**
   * Unlock to allow both puts and takes.
   */
  private void fullyUnlock() {
    takeLock.unlock();
    putLock.unlock();
  }
}
