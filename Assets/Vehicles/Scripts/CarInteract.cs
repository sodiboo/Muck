using UnityEngine;
using UnityEngine.Scripting;

public class CarInteract : MonoBehaviour, Interactable
{
    Car car;

    private void Awake()
    {
        car = GetComponentInParent<Car>();
    }

    public void Interact() {
        if (!car.inUse) {
            ClientSend.EnterVehicle(car);
        }
    }


    public void LocalExecute() { }


    public void AllExecute() { }


    public void ServerExecute(int fromClient = -1) { }


    public void RemoveObject() { }


    public string GetName() {
        if (!car.inUse) return "";
        return "Enter Vehicle";
    }


    public bool IsStarted() => false;
}