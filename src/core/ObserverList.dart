import "../data_collectors/interfaces/data-event-observer-interfaces.dart";

class ObserverList<Observer> {

    List<Observer> _observers;

    ObserverList() {
        _observers = new List<Observer>();
    }

    void add(Observer listener) {
        _observers.add(listener);
    }

    List<Observer> getAll() {
        return _observers;
    }

}