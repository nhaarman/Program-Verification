public interface BlockingQueue<E> extends Queue<E> {

  void put(E e) throws InterruptedException;

  E take() throws InterruptedException;

}
