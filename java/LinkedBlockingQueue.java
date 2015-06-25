public class LinkedBlockingQueue<E> implements BlockingQueue<E> {

  /** The capacity bound, or Integer.MAX_VALUE if none */
  private final int capacity;

  /** Current number of elements */
  private final AtomicInteger count = new AtomicInteger(0);

  /** Lock held by take, poll, etc */
  private final ReentrantLock takeLock = new ReentrantLock();

  /** Wait queue for waiting takes */
  private final Condition notEmpty = takeLock.newCondition();

  /** Lock held by put, offer, etc */
  private final ReentrantLock putLock = new ReentrantLock();

  /** Wait queue for waiting puts */
  private final Condition notFull = putLock.newCondition();

  /** Head of linked list */
  private transient Node<E> head;

  /** Tail of linked list */
  private transient Node<E> last;

  /**
   * Creates a <tt>LinkedBlockingQueue</tt> with the given (fixed) capacity.
   *
   * @param capacity the capacity of this queue
   * @throws IllegalArgumentException if <tt>capacity</tt> is not greater than zero
   */
  public LinkedBlockingQueue(int capacity) {
    if (capacity <= 0) throw new IllegalArgumentException();
    this.capacity = capacity;
    last = head = new Node<E>(null);
  }

  /**
   * Signals a waiting take. Called only from put/offer (which do not otherwise ordinarily lock takelock.)
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
  private void signalNotFull() {
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
   *
   * @param x the item
   */
  private void insert(E x) {
    last = last.next = new Node<E>(x);
  }

  /**
   * Removes a node from head of queue.
   *
   * @return the node
   */
  private E extract() {
    Node<E> first = head.next;
    head = first;
    E x = first.item;
    first.item = null;
    return x;
  }

  // this doc comment is a modified copy of the inherited doc comment,
  // without the reference to unlimited queues.

  /**
   * Inserts the specified element at the tail of this queue, waiting if necessary for space to become available.
   *
   * @throws InterruptedException {@inheritDoc}
   * @throws NullPointerException {@inheritDoc}
   */
  public void put(E e) throws InterruptedException {
    if (e == null) throw new NullPointerException();
    // Note: convention in all put/take/etc is to preset
    // local var holding count  negative to indicate failure unless set.
    int c = -1;
    final ReentrantLock putLock = this.putLock;
    final AtomicInteger count = this.count;
    putLock.lockInterruptibly();
    try {
            /*
             * Note that count is used in wait guard even though it is
             * not protected by lock. This works because count can
             * only decrease at this point (all other puts are shut
             * out by lock), and we (or some other waiting put) are
             * signalled if it ever changes from
             * capacity. Similarly for all other uses of count in
             * other wait guards.
             */
      try {
        while (count.get() == capacity) {
          notFull.await();
        }
      } catch (InterruptedException ie) {
        notFull.signal(); // propagate to a non-interrupted thread
        throw ie;
      }
      insert(e);
      c = count.getAndIncrement();
      if (c + 1 < capacity) {
        notFull.signal();
      }
    } finally {
      putLock.unlock();
    }
    if (c == 0) {
      signalNotEmpty();
    }
  }

  /**
   * Inserts the specified element at the tail of this queue if it is possible to do so immediately without exceeding the queue's capacity, returning <tt>true</tt> upon success and
   * <tt>false</tt> if this queue is full. When using a capacity-restricted queue, this method is generally preferable to method {@link BlockingQueue#add add}, which can fail to
   * insert an element only by throwing an exception.
   *
   * @throws NullPointerException if the specified element is null
   */
  public boolean offer(E e) {
    if (e == null) throw new NullPointerException();
    final AtomicInteger count = this.count;
    if (count.get() == capacity) {
      return false;
    }
    int c = -1;
    final ReentrantLock putLock = this.putLock;
    putLock.lock();
    try {
      if (count.get() < capacity) {
        insert(e);
        c = count.getAndIncrement();
        if (c + 1 < capacity) {
          notFull.signal();
        }
      }
    } finally {
      putLock.unlock();
    }
    if (c == 0) {
      signalNotEmpty();
    }
    return c >= 0;
  }

  public E take() throws InterruptedException {
    E x;
    int c = -1;
    final AtomicInteger count = this.count;
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lockInterruptibly();
    try {
      try {
        while (count.get() == 0) {
          notEmpty.await();
        }
      } catch (InterruptedException ie) {
        notEmpty.signal(); // propagate to a non-interrupted thread
        throw ie;
      }

      x = extract();
      c = count.getAndDecrement();
      if (c > 1) {
        notEmpty.signal();
      }
    } finally {
      takeLock.unlock();
    }
    if (c == capacity) {
      signalNotFull();
    }
    return x;
  }

  public E poll() {
    final AtomicInteger count = this.count;
    if (count.get() == 0) {
      return null;
    }
    E x = null;
    int c = -1;
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lock();
    try {
      if (count.get() > 0) {
        x = extract();
        c = count.getAndDecrement();
        if (c > 1) {
          notEmpty.signal();
        }
      }
    } finally {
      takeLock.unlock();
    }
    if (c == capacity) {
      signalNotFull();
    }
    return x;
  }

  public E peek() {
    if (count.get() == 0) {
      return null;
    }
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lock();
    try {
      Node<E> first = head.next;
      if (first == null) {
        return null;
      } else {
        return first.item;
      }
    } finally {
      takeLock.unlock();
    }
  }

  static class Node<E> {
    /** The item, volatile to ensure barrier separating write and read */
    volatile E item;

    Node<E> next;

    Node(E x) {
      item = x;
    }
  }
}

